# Políticas de retención de datos

La política de retención de datos son las reglas que determinan cuánto tiempo se conservan las copias de seguridad antes de ser eliminadas. Esta política define qué datos se conservan, por cuánto tiempo y bajo qué condiciones.

Las políticas de retención establecen un equilibrio entre varios factores:

-   **Disponibilidad de recuperación**: Durante cuánto tiempo y granularidad podemos recuperar históricos.
-   **Optimización de recursos**: El espacio de almacenamiento y los costes asociados.
-   **Cumplimiento normativo**: Requisitos legales sobre conservación y eliminación de datos.

## Importancia de una política de retención bien diseñada

Una política de retención adecuada no es simplemente una cuestión técnica, sino un componente estratégico en la gestión de datos por varias razones:

### Impacto en costes y recursos

Sin una política clara, existe la tendencia natural a "guardar todo por si acaso", lo que lleva a:

-   Crecimiento descontrolado del almacenamiento necesario
-   Aumento continuo de costes
-   Mayor complejidad en la gestión de los sistemas de backup
-   Tiempos de restauración más prolongados al tener que navegar por múltiples versiones

### Aspectos legales y de cumplimiento

Muchas regulaciones (GDPR, HIPAA, normativas sectoriales) tienen requisitos específicos sobre:

-   Períodos mínimos obligatorios de retención
-   Plazos máximos de conservación
-   Métodos de eliminación segura
-   Documentación del ciclo de vida de los datos

Un ejemplo concreto: GDPR requiere que los datos personales no se conserven más allá de lo necesario para los fines para los que fueron recogidos, lo que implica la necesidad de políticas de eliminación programada.

### Eficiencia en la recuperación

La capacidad de recuperación se optimiza cuando:

-   Los puntos de restauración están estratégicamente distribuidos en el tiempo
-   Existe un equilibrio entre cantidad y antigüedad de backups
-   Se evita la duplicación innecesaria de datos históricos
-   Se prioriza la disponibilidad de los datos más relevantes

## Modelos comunes de políticas de retención

Existen diferentes enfoques para estructurar una política de retención.

### 1. Política de rotación básica (GFS - Grandfather-Father-Son)

Este es uno de los modelos más utilizados. Está basado en una estructura jerárquica:

-   **Copias diarias (Son)**: Se conservan durante 7-14 días
-   **Copias semanales (Father)**: Se conservan durante 4-5 semanas
-   **Copias mensuales (Grandfather)**: Se conservan durante 12 meses
-   **Copias anuales**: Se conservan durante 5-7 años (o según requisitos normativos)

#### Ejemplo GFS

Para un sistema con backups diarios, aplicando GFS podríamos tener:

-   7 copias diarias (una semana completa)
-   4 copias semanales (último backup de cada una de las 4 semanas anteriores)
-   12 copias mensuales (último backup de cada uno de los 12 meses anteriores)
-   5 copias anuales (último backup de cada uno de los 5 años anteriores)

Esto proporciona 28 puntos de restauración cubriendo un período de 5 años, pero con mayor densidad en el pasado reciente.

### 2. Política basada en valor empresarial (VBR - Value-Based Retention)

Este enfoque clasifica los datos según su importancia para el negocio:

-   **Datos críticos**: Mayor frecuencia de backup y períodos de retención más largos
-   **Datos importantes**: Frecuencia media y retención estándar
-   **Datos rutinarios**: Menor frecuencia y períodos cortos de retención

#### Ejemplo VBR

-   Base de datos de transacciones: Backups cada 6 horas, retención de 30 días para copias diarias, 12 meses para mensuales
-   Contenido de la web: Backups semanales, retención de 2 semanas
-   Logs del sistema: Backups diarios, retención de 7 días

### 3. Política de retención logarítmica

Este modelo establece una distribución no lineal de los puntos de restauración, con mayor densidad en el pasado reciente y menor en el pasado distante:

-   Todos los backups de la última semana
-   Una copia por semana del último mes
-   Una copia por mes del último año
-   Una copia por año para períodos anteriores

Este enfoque optimiza el equilibrio entre cobertura temporal y eficiencia de almacenamiento.

#### 3.1 Diferencia entre logarítmica y GFS

Las políticas logarítmicas y GFS se comportan para muchas situaciones de forma similar. Para entender la diferencia se puede poner un ejemplo.

En GFS haremos un backup todos los días (`d1` a `d7`). El domingo la copia `d7` será promocionada a semanal (`s1`), y si ya había un `s1` será promocionada a `s2` (la copia de hace dos domingos). La `s4` (de hace 4 domingos) será promocionada a mensual `m1`. Y así sucesivamente, teniendo en cuenta que nunca habrá un `d8` o un `s5`.

En Logarítmico haremos un backup todos los días (`d1` hasta `d<infinito>`). Tras el backup examinaremos todas las copias archivadas. Si tiene 0 días (la de hoy) la conservamos. Las que tengan menos de 7 días de antigüedad también las conservamos. Entre 7 y 30 conservaremos 5 copias equiespaciadas que no tendrán porque ser las de los domingos.

[Ver el anexo](../anexos/retencion_gfs_logaritmica.md) para una descripción más amplia.

## Consideraciones prácticas para implementar políticas de retención

### Automatización y verificación

La implementación efectiva requiere:

-   Scripts o herramientas que apliquen automáticamente las reglas de retención
-   Mecanismos de verificación que confirmen la correcta aplicación
-   Alertas ante anomalías o desviaciones de la política

### Documentación y comunicación

Es esencial:

-   Documentar claramente las políticas para cada sistema
-   Comunicar a stakeholders las capacidades y limitaciones
-   Establecer procesos formales para solicitudes de restauración

### Revisión periódica

Las políticas deben revisarse regularmente:

-   Evaluar si siguen cumpliendo con requisitos técnicos y normativos
-   Ajustar según evolución de las necesidades del negocio
-   Adaptar a cambios tecnológicos o en infraestructura
