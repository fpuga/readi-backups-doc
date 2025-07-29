# Verificación

La _verificación_ está muy relacionado con las _métricas_ y cómo ellas forma parte de la _monitorización_. Las métricas están más enfocadas a una panorámica general, mientras que la verificación está enfocada a que la replica en destino es la esperada.

Conceptualmente la verificación debería implementarse a varios niveles, cada uno proporcionando diferentes grados de confianza. Pero en general la verificación se delega a las opciones que tenga la herramienta de backups que se emplee.

La verificación no tiene porqué ser un proceso asociado únicamente a una tarea concreta. Si no que puede implicar que aún existen las copias previas y no han sido alteradas.

## Verificación de completitud

Este nivel básico confirma que el proceso de backup ha finalizado y ha generado los archivos esperados:

Por ejemplo:

-   **Validación de tamaño**: El tamaño del backup está dentro del rango esperado.
-   **Conteo de archivos**: El número de archivos o elementos es el esperado.

## Verificación de integridad

Este nivel intermedio confirma que los datos respaldados no están corruptos:

Por ejemplo:

-   **Checksums**: Generación y verificación de hashes criptográficos (MD5, SHA-256, etc.)
-   **Verificación estructural**: Comprobación de la integridad del formato del archivo de backup

## Verificación de contenido

Este nivel avanzado confirma que los datos específicos que debían ser respaldados están presentes y son correctos:

Por ejemplo:

-   **Muestreo aleatorio**: Extracción y verificación de archivos seleccionados aleatoriamente
-   **Análisis estructural**: Para datos complejos como bases de datos, confirmación de la coherencia interna

## Periodicidad

Algunas pruebas de verificación son computacionalmente costosas por lo que también debe establecerse la periodicidad adecuada para ellas:

Por ejemplo:

-   Verificación de integridad (checksums): Con cada backup o semanal
-   Verificación de contenido (muestreo): Mensual
