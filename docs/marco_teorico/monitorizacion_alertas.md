# Monitorización y Alertas

[Las métricas](metricas.md) definen que debemos medir. La monitorización nos ayuda a definir cómo medirlo y visualizarlo. Las alertas son los avisos que debemos atender cuando hay problemas.

Un sistema efectivo de monitorización debe cubrir diferentes aspectos:

-   Métricas a nivel ejecución individual del backup (tarea)
-   Métricas a nivel sistema
-   Envío de alertas

## Monitorización a nivel de tarea

Supervisa cada operación individual de backup:

-   **Logs detallados**: Captura de inicio, finalización, errores y advertencias
-   **Códigos de salida**: Verificación programática del éxito
-   **Notificaciones**: Alertas inmediatas sobre fallos

En general la propia tarea de backup generará logs del proceso que enviará a un sistema de monitorización. Otra opción es que el log quede en el propio servidor y el sistema de monitorización se encargue de extraerlo pero no es lo ideal.

La tarea también puede encargarse de enviar alertas, pero suele ser preferible que se deleguen al sistema de monitorización, que también debe avisar cuando no haya recibido una notificación de backups dentro de la periodicidad programada.

## Monitorización a nivel de sistema

Proporciona una vista agregada del estado de todos los backups:

-   **Dashboards**: Visualización de métricas clave y tendencias
-   **Informes periódicos**: Resúmenes diarios/semanales/mensuales
-   **Análisis de tendencias**: Identificación de patrones problemáticos

El sistema recibe las métricas y logs de cada backup, los presenta de una forma agregada calculando las métricas establecidas, y envía alertas cuando resulte necesarios.

## Recolección de métricas

Para entornos con múltiples servidores, la recolección centralizada de métricas es esencial:

-   **Agentes de monitorización**: Instalados en cada servidor para recopilar datos locales
-   **APIs**: Interfaces programáticas para extraer información de herramientas de backup
-   **Push vs Pull**: Enviar los datos desde la propia tarea, o que el sistema de monitorización sea el responsable de ir a recogerlos.
-   **Externalizar**: Soluciones _self-hosted_ vs delegar en proveedores

## Alertas

El sistema de alertas debe equilibrar la información oportuna con la prevención de la fatiga por alertas:

### Niveles de alerta recomendados

**Crítico**: Requiere acción inmediata

-   Fallos de backup en sistemas de producción críticos
-   Superación del RPO establecido
-   Problemas de integridad detectados en backups

**Advertencia**: Requiere atención pronto

-   Tendencia de crecimiento inusual
-   Tiempo de backup aumentando significativamente
-   Aproximación a límites de almacenamiento

**Informativo**: Para seguimiento y mejora continua

-   Resúmenes periódicos de estado
-   Estadísticas de rendimiento
-   Cumplimiento de políticas

### Canales de notificación

Diversificar según la urgencia y el tipo de alerta:

-   Email para notificaciones no urgentes y resúmenes
-   Sistemas de mensajería o SMS para alertas importantes
-   Tickets automáticos en sistemas de gestión
