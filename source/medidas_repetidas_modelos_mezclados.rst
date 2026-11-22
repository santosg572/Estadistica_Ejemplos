medidas repetidas en modelos mezclados
======================================

Un modelo lineal mixto (LMM) para medidas repetidas evalúa cómo cambia una variable a lo largo del tiempo o bajo distintas condiciones en los mismos sujetos, modelando tanto efectos fijos (tratamiento, tiempo, interacción) como efectos aleatorios (variabilidad entre sujetos) y la correlación entre mediciones

**1. Escenario del ejemplo**

Supón un ensayo clínico para reducir la presión arterial sistólica (PAS) en pacientes divididos en dos grupos: Fármaco A y Placebo. Se mide la PAS en tres momentos: línea base (T0), semana 4 (T1) y semana 8 (T2).

**2. Estructura de los datos (formato largo)**

En los modelos mixtos, los datos suelen organizarse en formato largo (una fila por medición y sujeto):


.. list-table:: Título de la tabla
   :widths: 50 50 50 50 
   :header-rows: 1

   * - id_paciente	
     - grupo	
     - tiempo	
     - pas
   * - 1	
     - Fármaco A	
     - T0	
     - 150
   * - 1	
     - Fármaco A	
     - T1	
     - 138
   * - 1	
     - Fármaco A	
     - T2	
     - 128
   * - 2	
     - Placebo	
     - T0	
     - 152
   * - 2	
     - Placebo	
     - T1	
     - 149
   * - 2	
     - Placebo	
     - T2	
     - 147


