ejemplo completo y reproducible en R
====================================

Aquí tienes un ejemplo completo y reproducible en R que simula datos longitudinales (con algunos datos faltantes), ajusta el modelo mixto con lmerTest (para obtener valores p), realiza comparaciones post-hoc y grafica los resultados.

**1. Instalación y carga de paquetes**

.. code:: R

   # Instala los paquetes si no los tienes
   # install.packages(c("lmerTest", "emmeans", "ggplot2", "dplyr"))

   library(lmerTest) # Ajusta modelos mixtos y calcula valores p
   library(emmeans)  # Medias marginales y comparaciones por pares
   library(ggplot2)  # Gráficos
   library(dplyr)    # Manipulación de datos

**2. Simulación de datos (formato largo)**

Simularemos 30 pacientes (15 en Placebo y 15 con Fármaco A) medidos en 3 tiempos (T0, T1, T2).

.. code:: R

   set.seed(123)

   n_sujetos <- 30
   tiempos <- c("T0", "T1", "T2")

   # Crear base de datos en formato largo
   datos <- expand.grid(
     id_paciente = factor(1:n_sujetos),
     tiempo = factor(tiempos, levels = c("T0", "T1", "T2"))
   ) %>%
     arrange(id_paciente, tiempo) %>%
     mutate(
       grupo = factor(ifelse(as.numeric(id_paciente) <= 15, "Placebo", "Farmaco_A"),
                   levels = c("Placebo", "Farmaco_A"))
     )

   # Efecto aleatorio por paciente (diferente presión basal en cada persona)
   efecto_sujeto <- rnorm(n_sujetos, mean = 0, sd = 8)
   datos$u0 <- efecto_sujeto[as.numeric(datos$id_paciente)]

   # Generar presión arterial sistólica (PAS) con efecto de interacción
   datos <- datos %>%
     mutate(
       efecto_fijo = case_when(
         grupo == "Placebo"   & tiempo == "T0" ~ 150,
         grupo == "Placebo"   & tiempo == "T1" ~ 148,
         grupo == "Placebo"   & tiempo == "T2" ~ 147,
         grupo == "Farmaco_A" & tiempo == "T0" ~ 150,
         grupo == "Farmaco_A" & tiempo == "T1" ~ 138,
         grupo == "Farmaco_A" & tiempo == "T2" ~ 128
       ),
       pas = round(efecto_fijo + u0 + rnorm(n(), mean = 0, sd = 4), 1)
     ) %>%
     select(id_paciente, grupo, tiempo, pas)

   # Simular pérdida de seguimiento (2 datos faltantes en T2)
   datos$pas[c(6, 87)] <- NA

   head(datos, 9)

**3. Ajuste del modelo lineal mixto**

.. code:: R

   # Modelo con intercepto aleatorio por paciente (1 | id_paciente)
   modelo <- lmer(pas ~ grupo * tiempo + (1 | id_paciente), data = datos)

   # Resumen de coeficientes (efectos fijos y varianza aleatoria)
   summary(modelo)

   # Tabla ANOVA tipo III (significancia global de grupo, tiempo e interacción)
   anova(modelo)

**4. Comparaciones post-hoc (¿En qué tiempo difieren los grupos?)**

Si la interacción grupo:tiempo es significativa, comparamos los grupos dentro de cada momento:

.. code:: R

   # Comparar Placebo vs Farmaco_A dentro de cada tiempo
   medias_marg <- emmeans(modelo, ~ grupo | tiempo)
   pairs(medias_marg, adjust = "tukey")

**5. Visualización de trayectorias individuales y medias**

.. code:: R

   ggplot(datos, aes(x = tiempo, y = pas, color = grupo, group = id_paciente)) +
     geom_line(alpha = 0.25) + # Trayectorias individuales
     stat_summary(aes(group = grupo), fun = mean, geom = "line", linewidth = 1.3) +
     stat_summary(aes(group = grupo), fun = mean, geom = "point", size = 3) +
     labs(
       title = "Evolución de la Presión Arterial Sistólica (PAS)",
       subtitle = "Líneas tenues: pacientes individuales | Líneas gruesas: media por grupo",
       x = "Tiempo de medición",
       y = "PAS (mmHg)",
       color = "Tratamiento"
     ) +
     theme_minimal()

Si quieres adaptar el script a tu análisis, indícame:

• Si necesitas incluir pendientes aleatorias (por ejemplo, (tiempo | id_paciente))
• Si tus datos tienen estructuras de correlación específicas (como AR1 con el paquete nlme)
• Cómo interpretar una salida específica de summary() o anova()





