# SIGCOM
Sistema de Costeo Hospitalario.
Este script permite automatizar procesos del sistema de costeo hospitalario

Descripcion de los script
SIGCOM Farmacia: Crea el reporte de SIGCOM de la farmacia, analizando las distintas BBDD hospitalarias
SIGCOM Unidades: Consolida los reportes SIGCOM de las unidades de apoyo, las cuales envian sus reportes mensuales
SIGCOM RRHH: Categoriza el RRHH de acuerdo a las reglas del SIGCOM, reporta las personas que no estan asignadas a algun centro de costo
SIGCOM-Produccion: Busca la produccion mensual en distintos reportes como el REM serie A, REM Serie B, Censo Hospitalario y la asigna a los centros de costo
SIGCOM-SIGFE: Toma de base el devengo mensual, asigna los gastos a los centros de costo, tiene reglas de asignacion por ejemplo el consumo del mes, el consumo de los ultimos 3 meses, Metros cuadrados, asignacion directa, entre otros
SIGCOM Cubo 9: Convierte la tabla final que reporta el SIGCOM en una BBDD la cual es mas facil de manejar
