# Diferencia entre política logarítmica y GFS (Grandfather-Father-Son)

Ambas políticas de retención buscan optimizar el equilibrio entre cobertura temporal y uso eficiente del almacenamiento, pero lo hacen con enfoques diferentes.

## Estructura básica

**GFS**:

Utiliza una estructura jerárquica con categorías claramente definidas:

-   Son (Hijo): Copias diarias (normalmente 7-14 días)
-   Father (Padre): Copias semanales (normalmente 4-5 semanas)
-   Grandfather (Abuelo): Copias mensuales (normalmente 12 meses)
-   A veces se añade una capa adicional de copias anuales

**Logarítmica**:

Se basa en una distribución matemática donde la densidad de puntos de restauración disminuye logarítmicamente a medida que retrocedemos en el tiempo. No tiene categorías fijas predefinidas, sino una distribución continua basada en la antigüedad de los backups.

## Distribución temporal

**GFS**:

La distribución es escalonada y predefinida. Por ejemplo, en un esquema típico:

-   Primeros 14 días: Una copia por día (14 copias)
-   Siguientes 4 semanas: Una copia por semana (4 copias)
-   Siguientes 12 meses: Una copia por mes (12 copias)

Esto crea "saltos" o discontinuidades en la densidad de puntos de restauración.

**Logarítmica**:

La distribución sigue una curva logarítmica continua. La densidad de puntos de restauración disminuye gradualmente sin saltos bruscos. Por ejemplo:

-   Primer día: 24 copias (una cada hora)
-   Segunda semana: 7 copias (una por día)
-   Tercer mes: 4 copias (una por semana)
-   Resto del año: 12 copias (una por mes)

## Criterios de selección y retención

**GFS**:

Se basa en reglas fijas para seleccionar qué copias conservar:

-   "Conserva el último backup de cada día durante X días"
-   "Conserva el último backup de cada semana durante Y semanas"
-   "Conserva el último backup de cada mes durante Z meses"

La selección depende de la categoría temporal (día/semana/mes) y se aplica de forma discreta.

**Logarítmica**:

La selección se basa en una fórmula matemática que considera la antigüedad del backup:

-   Backups más recientes: Se conservan casi todos
-   Backups más antiguos: Se reduce progresivamente la densidad

A menudo utiliza algoritmos que calculan dinámicamente qué backups mantener para conseguir la distribución deseada.

## Flexibilidad y adaptabilidad

**GFS**:

-   Estructura más rígida y predecible
-   Más fácil de explicar y visualizar
-   Menos adaptable a necesidades cambiantes
-   Requiere definir explícitamente cada nivel de retención

**Logarítmica**:

-   Estructura más flexible y dinámica
-   Se adapta mejor a diferentes períodos sin cambiar la configuración
-   Puede optimizarse según patrones de acceso y requisitos específicos
-   Permite ajustar la "pendiente" de la curva logarítmica según necesidades

## Ejemplo práctico comparativo

Veamos cómo ambas políticas distribuirían puntos de restauración a lo largo de un año:

**GFS (esquema típico):**

-   Últimos 14 días: 14 copias (una diaria)
-   Últimas 4 semanas: 4 copias (una semanal)
-   Últimos 12 meses: 12 copias (una mensual)
-   Total: 30 puntos de restauración, con distribución escalonada

**Logarítmica (ejemplo):**

-   Última semana: 7 copias (una diaria)
-   Segunda semana: 3-4 copias (espaciadas)
-   Tercer y cuarto semana: 2-3 copias
-   Segundo mes: 3-4 copias
-   Meses 3-6: 4-6 copias
-   Meses 7-12: 6 copias
-   Total: aproximadamente 25-30 puntos de restauración, con distribución gradual

## Implementación

**GFS**:

```python
# Pseudocódigo de reglas GFS
def aplicar_politica_gfs(backups):
    conservar = []

    # Conservar diarios (últimos 14 días)
    for i in range(14):
        conservar.append(obtener_backup_del_dia(hoy - i días))

    # Conservar semanales (últimas 4 semanas)
    for i in range(4):
        conservar.append(obtener_backup_de_semana(semana_actual - i))

    # Conservar mensuales (últimos 12 meses)
    for i in range(12):
        conservar.append(obtener_backup_de_mes(mes_actual - i))

    return conservar
```

**Logarítmica**:

```python
# Pseudocódigo de política logarítmica
def aplicar_politica_logaritmica(backups):
    conservar = []
    ahora = fecha_actual()

    for backup in backups:
        edad_dias = (ahora - backup.fecha).dias

        # Fórmula logarítmica para determinar si conservar
        # Más reciente = más probable que se conserve
        if edad_dias == 0:
            # Conservar todos los del día actual
            conservar.append(backup)
        elif edad_dias <= 7:
            # Conservar 1 por día en la última semana
            if es_unico_en_dia(backup):
                conservar.append(backup)
        elif edad_dias <= 30:
            # Para el último mes, densidad decreciente
            if edad_dias % int(math.log(edad_dias) + 1) == 0:
                conservar.append(backup)
        else:
            # Para períodos más antiguos
            if edad_dias % int(math.log(edad_dias) * 2) == 0:
                conservar.append(backup)

    return conservar

# for edad in range(7, 30):
#     print(f"edad {edad} {'conservar' if edad % int(math.log(edad) + 1) == 0 else 'borrar'}")
```

## Ventajas y desventajas

### GFS

**Ventajas**:

-   Fácil de entender, comunicar y auditar
-   Simple de implementar con herramientas estándar
-   Ofrece una estructura predecible para los administradores
-   Bien soportada por la mayoría de herramientas de backup

**Desventajas**:

-   Menos eficiente en la distribución de puntos de restauración
-   Crea "saltos" en la granularidad temporal
-   Menos óptima en términos de uso del almacenamiento
-   Puede requerir más espacio para la misma cobertura temporal

### Logarítmica

**Ventajas**:

-   Distribución más eficiente de puntos de restauración
-   Mayor cobertura temporal con el mismo número de backups
-   Transición suave entre diferentes períodos temporales
-   Mejor optimización del espacio utilizado

**Desventajas**:

-   Más compleja de implementar correctamente
-   Puede ser difícil de explicar a stakeholders no técnicos
-   Menos herramientas la soportan nativamente
-   Requiere algoritmos más sofisticados para la selección y eliminación

## ¿Cuál elegir?

La elección entre GFS y logarítmica depende de varios factores:

-   **Requisitos de negocio**: Si necesitas puntos de restauración claramente definidos por períodos (diario, semanal, mensual), GFS es más directo. Si buscas optimizar el uso del almacenamiento manteniendo buena cobertura temporal, la logarítmica es mejor.

-   **Limitaciones de almacenamiento**: La política logarítmica suele ser más eficiente en términos de espacio para longitudes similares de historia.

-   **Herramientas disponibles**: GFS está ampliamente soportado, mientras que la logarítmica puede requerir implementación personalizada.

-   **Complejidad aceptable**: GFS es más sencillo de implementar y verificar; la logarítmica requiere algoritmos más sofisticados.

-   **Patrones de acceso**: Si los datos recientes se acceden con mucha más frecuencia, la política logarítmica se alinea mejor con estos patrones de uso.

Una combinación híbrida también es posible, utilizando una retención casi continua para el pasado reciente (similar a la logarítmica) y luego aplicando reglas GFS para períodos más antiguos.
