Incluir pendientes aleatorias significa permitir que cada individuo tenga no solo un punto de partida distinto (intercepto aleatorio), sino también su propia tasa de cambio o evolución en el tiempo.

**1. ¿Cuándo usar pendientes aleatorias?**

• Solo intercepto (1 | id): Asume que todos los sujetos de un mismo grupo evolucionan en líneas paralelas a lo largo del tiempo.

• Intercepto y pendiente (tiempo | id): Permite que algunos pacientes respondan muy rápido al tratamiento y otros muy lento, aunque pertenezcan al mismo grupo.

.. Nota::

   Nota técnica importante: Para ajustar pendientes aleatorias en función del tiempo, el tiempo suele modelarse como una variable numérica continua (ej. 0, 4, 8 semanas) en lugar de un factor categórico, ya que un factor con 3 niveles y una pendiente aleatoria por sujeto puede generar exceso de parámetros (singular fit o falta de convergencia).

**2. Ejemplo reproducible en R con pendientes aleatorias**

.. code:: R

   library(lmerTest)
   library(ggplot2)
   library(dplyr)

   set.seed(456)

   # 1. Simular datos con tiempo numérico (0, 4 y 8 semanas)
   n_sujetos <- 40
   semanas <- c(0, 4, 8)

   datos_pend <- expand.grid(
     id_paciente = factor(1:n_sujetos),
     semana = semanas
   ) %>%
     arrange(id_paciente, semana) %>%
     mutate(
       grupo = factor(ifelse(as.numeric(id_paciente) <= 20, "Placebo", "Farmaco_A"),
                   levels = c("Placebo", "Farmaco_A"))
     )

   # Efectos aleatorios por paciente:
   # u0 = desviación en el nivel basal (intercepto)
   # u1 = desviación en la velocidad de cambio por semana (pendiente)
   u0 <- rnorm(n_sujetos, mean = 0, sd = 8)
   u1 <- rnorm(n_sujetos, mean = 0, sd = 1.2)

   datos_pend <- datos_pend %>%
     mutate(
       # Pendiente fija: Placebo baja -0.3 mmHg/sem; Farmaco_A baja -2.8 mmHg/sem
       pendiente_fija = ifelse(grupo == "Placebo", -0.3, -2.8),
       pas = round((150 + u0[as.numeric(id_paciente)]) +
                (pendiente_fija + u1[as.numeric(id_paciente)]) * semana +
                rnorm(n(), 0, 3), 1)
     )

   # 2. Ajustar ambos modelos para compararlos
   # Modelo A: Solo intercepto aleatorio (líneas paralelas por sujeto)
   mod_intercepto <- lmer(pas ~ grupo * semana + (1 | id_paciente), data = datos_pend)

   # Modelo B: Intercepto y pendiente aleatorios (cada sujeto tiene su propia inclinación)
   mod_pendiente  <- lmer(pas ~ grupo * semana + (semana | id_paciente), data = datos_pend)

   # 3. Comparar si las pendientes aleatorias mejoran significativamente el ajuste
   anova(mod_intercepto, mod_pendiente)

   # 4. Ver resultados del modelo con pendientes aleatorias
   summary(mod_pendiente)

**3. ¿Cómo interpretar la salida?**

1. anova(mod_intercepto, mod_pendiente): Si el valor p (Pr(>Chisq)) es menor a 0.05 (y el AIC/BIC es menor en mod_pendiente), se justifica incluir pendientes aleatorias porque los pacientes realmente evolucionan a ritmos distintos.

2. Bloque Random effects en summary():

	• id_paciente (Intercept): Variabilidad en el valor inicial (semana 0).
	• semana: Variabilidad en la tasa de cambio entre pacientes.
	• Corr: Correlación entre el punto de partida y la pendiente (ej. una correlación negativa indica que quienes empiezan con presión más alta tienden a bajar más rápido).

3. Advertencia boundary (singular) fit: Si aparece este mensaje, significa que la varianza de la pendiente aleatoria es casi cero o hay pocos datos por sujeto para estimarla; en ese caso, conviene volver al modelo con solo (1 | id_paciente).


**4. Gráfico de las rectas ajustadas por paciente**

.. code:: R

   datos_pend$prediccion <- predict(mod_pendiente)

   ggplot(datos_pend, aes(x = semana, y = pas, color = grupo)) +
     geom_point(alpha = 0.3) +
     # Rectas individuales con distinta pendiente
     geom_line(aes(y = prediccion, group = id_paciente), alpha = 0.4) +
     labs(
       title = "Modelo con Interceptos y Pendientes Aleatorios",
       subtitle = "Cada línea representa la trayectoria estimada de un paciente",
       x = "Semanas",
       y = "PAS (mmHg)"
     ) +
     theme_minimal()
 
Si deseas profundizar en este modelo, dime:

• Si quieres ver cómo especificar pendientes sin correlación ((semana || id_paciente)) cuando hay problemas de convergencia
• Si tus datos muestran una curva no lineal en el tiempo (polinomios o splines)
• Cómo extraer los valores individuales (BLUPs) de cada sujeto con ranef()


