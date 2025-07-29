---
title: Introducción
---

# Introducción a las copias de seguridad

## Conceptos fundamentales

Una copia de seguridad es una réplica de datos almacenada en una ubicación separada del original para recuperarlos en caso de pérdida o corrupción. Los conceptos clave incluyen:

-   **Backup**: El proceso de copiar y almacenar datos
-   **Restore**: El proceso de recuperación de datos desde las copias
-   **RPO (Recovery Point Objective)**: Máxima cantidad de datos que se puede perder, medida en tiempo
-   **RTO (Recovery Time Objective)**: Tiempo máximo aceptable para restaurar completamente el sistema
-   **Retención**: Período durante el cual se conservan las copias
-   **Point in Time Recovery (PITR)**: Recuperación de los datos en un punto concreto del tiempo.
-   **Full / Incremental / Differential**. Si la copia es completa o sólo se transmiten los cambios.
-   **Físico / Lógico**. En base de datos hace referencia a almacenar los datos cómo SQL o cómo ficheros en disco. En sistemas de archivos puede hacer referencia a los ficheros en sí, o a los bloques (bytes) en el disco.
-   **Push / Pull**. Si la copia se efectúa desde la fuente al destino o viceversa.
-   **Disaster Recovery Plan (DRP)**. Un Plan de Recuperación ante Desastres es un conjunto documentado de políticas, procedimientos y medidas diseñadas para restaurar los sistemas de una organización después de un evento.

## Importancia y necesidad de los backups

Los backups son esenciales porque:

1. Protegen contra pérdidas de datos por fallos de hardware, software o errores humanos
2. Permiten recuperarse de ciberataques como ransomware
3. Facilitan migraciones y actualizaciones
4. Son requeridos por normativas (GDPR, LOPD, ...) y compromisos contractuales

## Riesgos y amenazas habituales

Los principales riesgos que hacen necesarios los backups son:

-   **Fallos de hardware**: Sobre todo errores en el disco duro
-   **Errores de software**: Bugs, actualizaciones fallidas, corrupción de datos
-   **Errores humanos**: Eliminación accidental, despliegues destructivos
-   **Ataques maliciosos**: Ransomware, sabotaje interno/externo
-   **Desastres físicos**: Incendios, inundaciones, problemas eléctricos
-   **Incidentes en proveedores cloud**: Caídas de servicios, errores en plataformas

## Limitaciones de las copias de seguridad

Aunque potencialmente se puedan usar para ello, las copias de seguridad **no** son:

-   Sustitutos de sistemas de alta disponibilidad
-   Mecanismos de sincronización o [data replication](https://phoenixnap.com/kb/backup-vs-replication)
-   Garantía absoluta contra todos los riesgos posibles
-   Mecanismos de versionado, gestión de históricos o audit trail.

## Adecuación al riesgo

La estrategia de backup debe adaptarse a los riesgos específicos que queremos mitigar:

-   Contra **errores humanos** (borrado accidental): Un sistema de snapshots frecuentes puede ser suficiente
-   Contra **ransomware**: Se requieren backups que no puedan ser alcanzados por el ataque
-   Contra **desastres físicos**: Necesitamos copias en ubicaciones geográficas distintas
-   Contra **fallos de proveedor cloud**: Almacenar los backups en otro proveedor

Un cliente que gestiona datos críticos necesitará una estrategia más robusta que uno con un blog corporativo. No todos los sistemas requieren protección máxima contra todos los riesgos posibles, lo que permite optimizar costes y complejidad.

Una estrategia "segura" para servidores de "oficina", puede ser conectar un disco duro externo todas las noches a un servidor, ejecutar un script de copia y llevar el disco externo a otra ubicación segura. Pero ¿realmente existirá consistencia en hacer las copias?

El sistena de snapshot de un proveedor cloud puede ser muy cómodo y eficaz. Pero si alguien gana acceso a la cuenta de administración podrá atacar a la vez los datos y las copias.

## Seguridad de las copias

Las copias de seguridad, al contener datos potencialmente sensibles, requieren protección específica:

-   **Control de acceso**: Limitar quién puede acceder a los backups mediante autenticación y permisos
-   **Cifrado**: Proteger los datos en tránsito y almacenamiento para evitar acceso no autorizado
-   **Protección contra manipulación**: Verificar la integridad de las copias para detectar modificaciones no autorizadas
-   **Cumplimiento normativo**: Asegurar que la gestión de copias cumple con regulaciones sobre protección de datos

Un backup comprometido puede suponer una violación de datos tan grave como un ataque al sistema principal, por lo que su seguridad debe ser proporcional a la sensibilidad de la información almacenada.

## Citas

!!! quote "[Ryan Booz](https://www.softwareandbooz.com/adventures-in-postgresql-backups/)"
Backups are only as good as your ability to restore the data in the business appropriate timeframe.
