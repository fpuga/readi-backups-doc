# Pruebas de restauración

Un sistema de backup no es verdaderamente efectivo hasta que podemos responder con certeza a la pregunta: "¿Puedo restaurar la copia?". La monitorización y verificación de las copias de seguridad es tan importante como la implementación. Sin estas prácticas, podemos caer en una falsa sensación de seguridad mientras nuestros sistemas fallan silenciosamente.

La verificación de backups es algo crítico pero que suele ser descuidado en el sistema completo.

Tener backups que no se pueden restaurar es equivalente a no tener backups.

## Enfoques

Las pruebas de restauración pueden considerarse el nivel más alto y confiable del proceso de verificación.

Al igual que para el resto de procesos deberían recogerse métricas y estar en el sistema de monitorización.

Las pruebas de restauración pueden abordarse desde dos enfoques distintos:

-   **Pruebas de restauración del backup**. Se comprueba que los datos en sí son recuperables
-   **Pruebas de restauración del sistema**. Mayor nivel de confianza. Se comprueba que el sistema completo (no sólo los datos) son recuperables en el tiempo definido por el RTO. Implica la realización de **pruebas funcionales** para verificar que la aplicación funciona correctamente con los datos restaurados

## Automatización de pruebas de restauración

Las pruebas manuales son propensas a ser pospuestas y eventualmente olvidadas, por lo que las pruebas de restauración deberían automatizarse.

## Programación estratégica de pruebas

Las pruebas de restauración pueden programarse en base a distintos criterios. Por ejemplo:

**Frecuencia basada en criticidad**:

-   Sistemas críticos: Pruebas de restauración completa mensual o trimestral
-   Sistemas estándar: Pruebas trimestrales o semestrales
-   Sistemas no críticos: Pruebas anuales

**Pruebas tras cambios significativos**:

-   Después de actualizaciones importantes del software
-   Tras cambios en la infraestructura
-   Después de modificaciones al sistema de backup

## Proceso de pruebas

1. **Planificación**:

-   Definir el alcance de la prueba
-   Identificar los recursos necesarios
-   Establecer criterios de éxito
-   Programar con anticipación para minimizar impacto

2. **Ejecución**:

-   Documentar cada paso realizado
-   Registrar tiempos de ejecución
-   Anotar problemas encontrados

3. **Evaluación**:

-   Comparar con los criterios de éxito establecidos
-   Identificar áreas de mejora
-   Documentar lecciones aprendidas

4. **Actualización de procedimientos**:

-   Incorporar mejoras basadas en los resultados
-   Actualizar la documentación
-   Revisar políticas de backup si es necesario

## Cultura de verificación continua

Más allá de las herramientas y procesos, debe fomentarse una cultura organizacional que valore la verificación:

-   **Responsabilidad compartida**: Todo el equipo debe participar en la definición y revisión de las pruebas.
-   **Transparencia**: Los resultados de las verificaciones deben ser visibles para todos los interesados.
-   **Mejora continua**: Cada prueba de restauración debe generar aprendizajes que mejoren tanto el proceso de backup como el de verificación.
-   **Celebración del fracaso controlado**: Las pruebas que revelan problemas deben verse como éxitos, no como fracasos, ya que permiten corregir debilidades antes de emergencias reales.
-   **Simulación de desastres**: Realizar periódicamente un ejercicio de recuperación ante desastres donde se simule un escenario de fallo completo y se siga el plan de recuperación documentado. Esto puede ser complementando con simulacros no anunciados. Esto prueba no solo los aspectos técnicos sino también organizativos del plan de recuperación.
