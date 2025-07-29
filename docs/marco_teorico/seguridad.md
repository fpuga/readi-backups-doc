# Modelo de Amenaza y Seguridad

## ¿Qué es un modelo de amenaza?

Un modelo de amenaza (o _threat model_) es un ejercicio de análisis que permite identificar y evaluar las posibles amenazas a la seguridad de un sistema. En el contexto de las copias de seguridad, un modelo de amenaza nos ayuda a entender qué adversarios podrían querer atacar nuestro sistema de copias de seguridad, cuáles son sus objetivos y qué vulnerabilidades podrían explotar.

El objetivo no es crear un sistema 100% invulnerable, lo cual es imposible, sino entender los riesgos y diseñar un sistema que ofrezca un nivel de seguridad adecuado a las necesidades de la organización, equilibrando seguridad, coste y usabilidad.

Dos ejemplos de modelos de amenaza bien definidos son los de [BorgBackup](https://borgbackup.readthedocs.io/en/stable/internals/security.html) y [Restic](https://restic.readthedocs.io/en/latest/100_references.html#threat-model).

## Principios de seguridad en las copias de seguridad

-   **Confidencialidad**: La información almacenada en las copias de seguridad no debe ser accesible a personal no autorizado. El cifrado es la principal herramienta para garantizar la confidencialidad. Si un atacante consigue acceso al repositorio de backups, no debería poder leer los datos.

-   **Integridad**: Las copias de seguridad deben ser una representación fiel de los datos originales. No deben poder ser modificadas sin que nos demos cuenta. Las herramientas de backup modernas utilizan técnicas como los códigos de autenticación de mensajes (MAC) para garantizar que los datos no han sido alterados.

-   **Disponibilidad**: Los datos deben estar disponibles para ser restaurados cuando sea necesario. Esto implica proteger los backups contra borrados accidentales o maliciosos, y tener un plan de recuperación probado y fiable.

## Modelos de amenaza en la práctica

Tanto `borg` como `restic` diseñan su seguridad partiendo de la base de que el cliente (la máquina que se está copiando) es seguro, pero el servidor (donde se guardan las copias) no lo es.

Esto tiene implicaciones importantes:

-   **El cifrado se realiza en el cliente**: Los datos nunca abandonan la máquina de origen sin estar cifrados. La clave de cifrado nunca se envía al servidor.
-   **La integridad se verifica en el cliente**: El cliente puede detectar si los datos en el servidor han sido modificados o corrompidos.
-   **Un atacante con acceso al servidor no puede**:
    -   Leer el contenido de los backups.
    -   Modificar los backups existentes sin que el cliente lo detecte en la siguiente operación.
    -   Inyectar datos maliciosos en los backups.

Sin embargo, un atacante con acceso al servidor **sí podría**:

-   **Borrar o Modificar los backups (ransomware)**: Es la amenaza más difícil de mitigar. Si un atacante tiene control total del servidor, puede borrar todo el repositorio. Para evitarlo, se pueden usar políticas de retención inmutables (_append-only_) en el almacenamiento si el proveedor lo permite.
-   **Realizar ataques de denegación de servicio (DoS)**: Podría impedir que se realicen nuevas copias o que se restauren las existentes.
-   **Analizar metadatos**: Aunque no pueda leer los datos, podría inferir información a partir de los metadatos, como el tamaño de los ficheros, la frecuencia de los cambios, etc.
