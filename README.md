# SIGCOM
Sistema de Costeo Hospitalario.
Este script permite automatizar procesos del sistema de costeo hospitalario

Descripcion de los script:

### SIGCOM Farmacia:
Crea el reporte de SIGCOM de la farmacia, analizando las distintas BBDD hospitalarias
Se alimenta de las BBDD

![image](https://user-images.githubusercontent.com/62567977/184368236-2e4a63af-4456-44d5-9813-9900487e301f.png)

Genera

![image](https://user-images.githubusercontent.com/62567977/184369008-59fc4d51-953e-4d71-bd0a-46698a154df0.png)



### SIGCOM Unidades: 
Consolida los reportes SIGCOM de las unidades de apoyo, las cuales envian sus reportes mensuales

![image](https://user-images.githubusercontent.com/62567977/184368451-186fa092-c544-4c08-b58e-f45d1b807dbc.png)

Genera

![image](https://user-images.githubusercontent.com/62567977/184369173-49c90124-9b36-49e3-b7e0-8de6ebccf430.png)



### SIGCOM RRHH:
Categoriza el RRHH de acuerdo a las reglas del SIGCOM, reporta las personas que no estan asignadas a algun centro de costo

![image](https://user-images.githubusercontent.com/62567977/184367794-5cba4b27-3815-46a8-8d3a-f14f5116694e.png)


Genera

![image](https://user-images.githubusercontent.com/62567977/184369440-c8e8f141-a578-4c49-afbd-c416a8d0f460.png)


### SIGCOM-Produccion: 
Busca la produccion mensual en distintos reportes como el REM serie A, REM Serie B, Censo Hospitalario y la asigna a los centros de costo

![image](https://user-images.githubusercontent.com/62567977/184367491-cb278e79-cd38-42e0-b0ef-8a3ec497321a.png)


Genera

![image](https://user-images.githubusercontent.com/62567977/184368016-31d9f644-fe99-465c-aba4-5ad9462b09a5.png)


### SIGCOM-SIGFE: 
Toma de base el devengo mensual, asigna los gastos a los centros de costo, tiene reglas de asignacion por ejemplo el consumo del mes, el consumo de los ultimos 3 meses, Metros cuadrados, asignacion directa, entre otros

![image](https://user-images.githubusercontent.com/62567977/184371395-22150e4c-e771-4742-b71f-1d307fcae126.png)

Genera

![image](https://user-images.githubusercontent.com/62567977/184371515-e5a87760-947e-4d63-84ab-940ef20774f4.png)





### SIGCOM Cubo 9:
Convierte la tabla final que reporta el SIGCOM en una BBDD la cual es mas facil de manejar
