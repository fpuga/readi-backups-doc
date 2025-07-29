# Backup del Proveedor Cloud

La funcionalidad puede variar mucho de proveedor a proveedor.

Por ejemplo en el [servicio de backups de **Linode**](https://techdocs.akamai.com/cloud-computing/docs/backup-service):

-   La copia se guarda en un hardware distinto pero en el mismo datacenter
-   La retención es fija. Máximo 4 copias en cada momento. manual, 1 día, 7 días, 14 días.
-   Funciona a nivel ficheros, no snapshot/bloque. No vale para discos cifrados, y si cuadrara en medio de una transacción de la bd podría quedar corrupta.
-   2$ para los Linode de 1G (5$). 10$ para los Linode de 8G (48$)

Son una buena opción cómo primera línea de defensa para una estrategia de backups 3-2-1, pero no cómo una solución completa por los problemas de:

-   Mismo datacenter
-   Retención
-   Corrupción de la base de datos
