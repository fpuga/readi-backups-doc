# Point-In-Time Recovery (PITR)

Point-In-Time Recovery es la capacidad de restaurar un sistema al estado exacto en que se encontraba en cualquier momento dentro de una ventana temporal definida, no solo en los momentos específicos donde se realizaron backups.

Tradicionalmente, PITR se asocia con bases de datos, permitiendo recuperar el estado exacto de la base de datos al nivel de una transacción individual.

El concepto se puede extender a otros ámbitos cómo sistemas de archivos y entornos virtualizados:

## Bases de datos

Se implementa mediante la combinación de backups completos y logs de transacciones.

En PostgreSQL se implementa combinando una base de de backups físicos con la reproducción secuencial de los cambios registrados en el Write-Ahead Log (WAL) hasta el punto deseado.

-   [PostgreSQL Replication for Disaster Recovery](https://severalnines.com/blog/postgresql-replication-disaster-recovery/)
-   [Documentación de PostgreSQL sobre PITR](https://www.postgresql.org/docs/current/continuous-archiving.html)

## Sistemas de archivos

Se realiza mediante snapshots frecuentes o sistemas de versiones.

Ejemplos:

-   ZFS con snapshots frecuentes
-   Btrfs con snapshots incrementales

## Entornos virtualizados

Algunas plataformas de virtualización ofrecen capacidades similares a PITR:

-   VMware con Changed Block Tracking
-   Hyper-V con snapshots incrementales
-   Proxmox con backup continuo

## PITR y su relación con las políticas de retención

PITR está relacionado, pero es distinto a las políticas de retención:

-   **Granularidad vs. extensión**: La política de retención define cuánto tiempo hacia atrás podemos recuperar datos (extensión), mientras que PITR define la precisión con la que podemos seleccionar un momento específico dentro de esa ventana (granularidad).
-   **Ventana de PITR**: Es el período durante el cual es posible realizar una recuperación a cualquier punto en el tiempo. Esta ventana suele ser más corta que la política de retención completa.

### Ejemplo práctico

Una política de retención podría especificar:

-   Ventana PITR: 7 días (recuperación a cualquier punto dentro de la última semana)
-   Granularidad PITR: 1 minuto
-   Backups diarios: 30 días
-   Backups semanales: 3 meses
-   Backups mensuales: 1 año

En este caso, podemos recuperar a cualquier minuto dentro de los últimos 7 días, pero más allá de ese período, solo podemos recuperar a los puntos específicos donde se realizaron backups.

## Consideraciones de implementación para PITR

La implementación de PITR requiere consideraciones especiales:

-   **Volumen de datos**: Los logs de transacciones o cambios incrementales crecen significativamente en sistemas con mucha actividad.
-   **Rendimiento**: La captura continua de cambios puede impactar el rendimiento del sistema.
-   **Complejidad de restauración**: La recuperación a un punto específico puede requerir procesar numerosos archivos de logs o cambios incrementales.
-   **Pruebas de validación**: Es esencial verificar regularmente que la recuperación a puntos arbitrarios funciona correctamente.

## Integrando PITR en una política de retención completa

Para una estrategia que integre capacidades PITR habrá que tener en cuenta:

**Definición de la ventana PITR**:

-   Evaluar el RPO (Recovery Point Objective) necesario
-   Considerar el volumen de cambios y su impacto en almacenamiento
-   Definir la granularidad temporal necesaria

**Configuración de la política de retención para los componentes de PITR**:

-   Retención de logs de transacciones o cambios incrementales
-   Programación de backups base que sirven como puntos de consolidación
-   Políticas de purga automática para los logs antiguos

**Documentación clara de capacidades**:

-   Especificar qué sistemas tienen capacidad PITR y cuáles no
-   Definir la ventana temporal de PITR para cada sistema
-   Establecer procedimientos para solicitar y ejecutar recuperaciones a puntos específicos
