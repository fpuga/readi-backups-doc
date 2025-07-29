# Herramientas de Monitorización y Automatización

Si bien pueden existir herramientas específicas de automatización y monitorización para los backups cualquier herramienta generalista de este ámbito en la que el equipo tenga experiencia es una opción válida.

En el caso de las suites de backup la monitorización suele venir incluída en la propia herramienta.

Si se usan herramientas más generalistas cómo rsync la responsabilidad cae del lado de quien implemente la solución.

Otras herramientas cómo Borgmatic están ya preparadas para ser integradas en entornos de monitorización cómo [healthchecks.io](https://healthcheck.io/), [loki](https://grafana.com/docs/loki/latest/) o [Sentry](https://sentry.io/).

También es habitual encontrar roles de Ansible que permiten el despliegue de estas herramientas.

## Ejemplos

-   [Integración de Borgmatic con servicios de monitorización](https://torsion.org/borgmatic/docs/how-to/monitor-your-backups)
-   [Role de Ansible para Borgmatic](https://github.com/borgbase/ansible-role-borgbackup)
