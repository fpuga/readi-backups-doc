# RTO (Recovery Time Objective) y RPO (Recovery Point Objective)

Estos son los dos parámetros más habituales que se manejan a alto nivel para diseñar la estrategia de backup:

**RTO (Recovery Time Objective)**:

-   Define cuánto tiempo puede estar un sistema inoperativo
-   Determina la velocidad necesaria de restauración
-   Se establece según el coste de inactividad del sistema

**RPO (Recovery Point Objective)**:

-   Define cuánta pérdida de datos es aceptable
-   Determina la frecuencia necesaria de backups
-   Se establece según el valor de los datos generados por unidad de tiempo

Por ejemplo:

-   Un sistema crítico financiero podría requerir un RTO de 1 hora y un RPO de 5 minutos
-   Un blog corporativo podría tolerar un RTO de 24 horas y un RPO de 1 semana.

La relación entre estos parámetros y los costes es directa: reducir RTO y RPO incrementa significativamente la inversión necesaria en infraestructura y automatización.

## Referencias

-   [Qué es RPO y RTO](https://www.techtarget.com/searchstorage/feature/What-is-the-difference-between-RPO-and-RTO-from-a-backup-perspective)
