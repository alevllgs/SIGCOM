# Librerias ---------------------------------------------------------------
library(tidyverse)
library(lubridate)
library(janitor)
library(dplyr)


Cubo_9 <- readxl::read_excel("C:/Users/control.gestion3/OneDrive/BBDD Produccion/PERC/Cubos 9/Cubo_9 BBDD.xlsx")


PM_GRD <- c(1.3239,	1.1900,	1.2501,	1.3399,	1.3454,	1.3679,	1.3505,	1.3420,	1.1704,	1.2395,	1.1703,1.2219,
            1.2734,1.3280, 1.1678, 1.2583, 1.1628)

ambulatorio <- c(
  "274-CONSULTA NEUROLOGÍA",
  "275-CONSULTA REUMATOLOGÍA",
  "276-CONSULTA CARDIOLOGÍA",
  "277-CONSULTA DERMATOLOGÍA",                      
  "278-CONSULTA ONCOLOGÍA",
  "280-CONSULTA PSIQUIATRÍA",
  "281-CONSULTA ENDOCRINOLOGÍA",                    
  "282-CONSULTA NEUMOLOGÍA",
  "284-CONSULTA INFECTOLOGÍA",                      
  "285-CONSULTA NEFROLOGÍA",
  "286-CONSULTA GENÉTICA",                          
  "287-CONSULTA HEMATOLOGÍA",
  "288-CONSULTA GERIATRÍA",                         
  "289-CONSULTA FISIATRÍA",
  "290-CONSULTA GASTROENTEROLOGÍA",                 
  "292-CONSULTA NEUROCIRUGÍA",
  "294-PROGRAMA MANEJO DEL DOLOR",                  
  "295-CONSULTA SALUD OCUPACIONAL",
  "296-CONSULTA ANESTESIOLOGIA",                    
  "306-CONSULTA HEMATOLOGÍA ONCOLÓGICA",            
  "307-CONSULTA DE INMUNOLOGÍA",
  "309-CONSULTA CIRUGÍA GENERAL",                   
  "311-CONSULTA UROLOGÍA",
  "316-CONSULTA CIRUGÍA PLÁSTICA",                  
  "317-CONSULTA OFTALMOLOGÍA",
  "318-CONSULTA CIRUGÍA VASCULAR PERIFÉRICA",       
  "319-CONSULTA OTORRINOLARINGOLOGÍA",
  "323-CONSULTA CIRUGÍA MAXILOFACIAL",              
  "326-CONSULTA DE TRAUMATOLOGÍA",
  "328-CONSULTA PEDIATRÍA GENERAL",                 
  "329-CONSULTA NEONATOLOGÍA",
  "331-CONSULTA NEUROLOGÍA PEDIÁTRICA",             
  "342-CONSULTA TRAUMATOLOGÍA PEDIÁTRICA",
  "351-CONSULTA CIRUGÍA PEDIÁTRICA",                
  "353-CONSULTA GINECOLOGICA",
  "354-CONSULTA OBSTETRICIA",                       
  "230-CONSULTA NUTRICIÓN",
  "15102-CONSULTA MEDICINA INTERNA",
  "15103-CONSULTA NEUROLOGÍA",
  "15104-CONSULTA REUMATOLOGÍA",
  "15105-CONSULTA CARDIOLOGÍA",
  "15106-CONSULTA DERMATOLOGÍA",
  "15107-CONSULTA ONCOLOGÍA",
  "15109-CONSULTA PSIQUIATRÍA",
  "15110-CONSULTA ENDOCRINOLOGÍA",
  "15111-CONSULTA NEUMOLOGÍA",
  "15113-CONSULTA INFECTOLOGÍA",
  "15114-CONSULTA NEFROLOGÍA",
  "15115-CONSULTA GENÉTICA",
  "15116-CONSULTA HEMATOLOGÍA",
  "15117-CONSULTA GERIATRÍA",
  "15118-CONSULTA FISIATRÍA",
  "15119-CONSULTA GASTROENTEROLOGÍA",
  "15121-CONSULTA NEUROCIRUGÍA",
  "15124-CONSULTA SALUD OCUPACIONAL",
  "15125-CONSULTA ANESTESIOLOGIA",
  "15135-CONSULTA HEMATOLOGÍA ONCOLÓGICA",
  "15136-CONSULTA DE INMUNOLOGÍA",
  "15201-CONSULTA CIRUGÍA GENERAL",
  "15203-CONSULTA UROLOGÍA",
  "15208-CONSULTA CIRUGÍA PLÁSTICA",
  "15209-CONSULTA OFTALMOLOGÍA",
  "15210-CONSULTA CIRUGÍA VASCULAR PERIFÉRICA",
  "15211-CONSULTA OTORRINOLARINGOLOGÍA",
  "15215-CONSULTA CIRUGÍA MAXILOFACIAL",
  "15218-CONSULTA DE TRAUMATOLOGÍA",
  "15302-CONSULTA PEDIATRÍA GENERAL",
  "15303-CONSULTA NEONATOLOGÍA",
  "15305-CONSULTA NEUROLOGÍA PEDIÁTRICA",
  "15316-CONSULTA TRAUMATOLOGÍA PEDIÁTRICA",
  "15409-CONSULTA CIRUGÍA PEDIÁTRICA",
  "15502-CONSULTA GINECOLOGICA",
  "15503-CONSULTA OBSTETRICIA",
  "15008-CONSULTA NUTRICIÓN"
  
)

cma <- c("465-QUIRÓFANO AMBULATORIO DE EMERGENCIA",
         "471-QUIRÓFANOS MAYOR AMBULATORIA")


hospitalizacion <- c(
  "65-HOSPITALIZACIÓN PENSIONADOS",
  "66-HOSPITALIZACIÓN MEDICINA INTERNA",            
  "72-HOSPITALIZACIÓN NEUROLOGÍA",
  "87-HOSPITALIZACIÓN ONCOLOGÍA",                   
  "90-HOSPITALIZACIÓN QUIRÚRGICA",
  "96-HOSPITALIZACIÓN UROLOGÍA",                    
  "98-HOSPITALIZACIÓN NEUROCIRUGÍA",
  "99-HOSPITALIZACIÓN OFTALMOLOGÍA",                
  "100-HOSPITALIZACIÓN OTORRINOLARINGOLOGÍA",
  "111-HOSPITALIZACIÓN TRAUMATOLOGÍA",              
  "113-HOSPITALIZACIÓN OBSTETRICIA",
  "114-HOSPITALIZACIÓN GINECOLOGÍA",                
  "116-HOSPITALIZACIÓN PEDIATRÍA",
  "130-HOSPITALIZACIÓN TRAUMATOLOGÍA PEDIÁTRICA",   
  "136-HOSPITALIZACIÓN NEUROCIRUGÍA PEDIÁTRICA",
  "149-HOSPITALIZACIÓN PSIQUIATRÍA")

hospitalizacion_uci <- c("166-UNIDAD DE CUIDADOS INTENSIVOS",
                         "169-UNIDAD DE CUIDADOS INTENSIVOS NEONATOS",     
                         "170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA",
                         "180-UNIDAD DE CUIDADOS INTERMEDIOS ADULTOS",     
                         "198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS",
                         "196-UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA",
                         "177-UNIDAD DE CUIDADOS CORONARIOS"
)

hospitalizacion_qx <- c(
  "462-QUIRÓFANOS CABEZA Y CUELLO",
  "464-QUIRÓFANOS CARDIOVASCULAR",                  
  "467-QUIRÓFANOS DIGESTIVA",
  "470-QUIRÓFANOS GINECOLOGÍA",                     
  "475-QUIRÓFANOS NEUROCIRUGÍA",
  "476-QUIRÓFANOS OBSTETRICIA",                     
  "477-QUIRÓFANOS ODONTOLOGICA",
  "478-QUIRÓFANOS OFTALMOLOGÍA",                    
  "480-QUIRÓFANOS OTORRINOLARINGOLOGÍA",
  "483-QUIRÓFANOS PROCTOLOGÍA",                     
  "484-QUIRÓFANOS TORACICA",
  "485-QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA",       
  "486-QUIRÓFANOS UROLOGÍA",
  "487-QUIRÓFANOS VASCULAR",                        
  "493-QUIRÓFANOS CIRUGÍA PLÁSTICA",
  "494-QUIRÓFANOS CIRUGÍA TORACICA",                
  "495-QUIRÓFANOS CIRUGÍA VASCULAR",
  "797-QUIROFANOS CIRUGIA CARDIACA")

emergencias <- c("216-EMERGENCIAS PEDIÁTRICAS",
                 "357-EMERGENCIAS ODONTOLOGICAS")


# Urgencia ----------------------------------------------------------------
i4 <- Cubo_9 %>% filter(CC %in% emergencias & Item=="Total RRHH")  %>% group_by(Fecha) %>% summarise("Gasto RRHH 2021" = sum(total))
p4 <- Cubo_9 %>% filter(CC %in% emergencias & Item=="p1")  %>% group_by(Fecha) %>% summarise("Producción 2021" = sum(total))  
i4 <- inner_join(i4,p4) %>% 
  mutate("Cod"=4, "Trazadora"="Atenciones de Emergencia", "Mes-Año"=Fecha, "Establecimiento"="HOSPITAL DE NIÑOS ROBERTO DEL RÍO",
         "Código DEIS"="109101", "PM GRD 2021"="", "Gasto RRHH 2021"=`Gasto RRHH 2021`,"Producción 2021"=`Producción 2021`,"Costo por Actividad 2021"= round(`Gasto RRHH 2021`/`Producción 2021`)) %>% 
  select(Cod, Trazadora, `Mes-Año`, Establecimiento, `Código DEIS`, `PM GRD 2021`, `Gasto RRHH 2021`, `Producción 2021`,`Costo por Actividad 2021` )

# Ambulatorio -------------------------------------------------------------
i3 <- Cubo_9 %>% filter(CC %in% ambulatorio & Item=="Total RRHH")  %>% group_by(Fecha) %>% summarise("Gasto RRHH 2021" = sum(total))
p3 <- Cubo_9 %>% filter(CC %in% ambulatorio & Item=="p1")  %>% group_by(Fecha) %>% summarise("Producción 2021" = sum(total))
p33 <- Cubo_9 %>% filter(CC %in% ambulatorio & Item=="p3")  %>% group_by(Fecha) %>% summarise("Producción 2021" = sum(total))
p3 <- data.frame(Fecha=p3$Fecha, "Producción 2021"= p3$`Producción 2021`+p33$`Producción 2021`)
colnames(p3)[2] <- "Producción 2021"
i3 <- inner_join(i3,p3) %>% 
  mutate("Cod"=3, "Trazadora"="Consultas de Especialidad", "Mes-Año"=Fecha, "Establecimiento"="HOSPITAL DE NIÑOS ROBERTO DEL RÍO",
         "Código DEIS"="109101", "PM GRD 2021"="", "Gasto RRHH 2021"=`Gasto RRHH 2021`,"Producción 2021"=`Producción 2021`,
         "Costo por Actividad 2021"= round(`Gasto RRHH 2021`/`Producción 2021`)) %>% 
  select(Cod, Trazadora, `Mes-Año`, Establecimiento, `Código DEIS`, `PM GRD 2021`, `Gasto RRHH 2021`, `Producción 2021`,`Costo por Actividad 2021`)

# CMA ---------------------------------------------------------------------
i2 <- Cubo_9 %>% filter(CC %in% cma & Item=="Total RRHH")  %>% group_by(Fecha) %>% summarise("Gasto RRHH 2021" = sum(total))
p2 <- Cubo_9 %>% filter(CC %in% cma & Item=="p1")  %>% group_by(Fecha) %>% summarise("Producción 2021" = sum(total))
i2 <- inner_join(i2,p2) %>% 
  mutate("Cod"=2, "Trazadora"="Cirugía Mayor Ambulatoria", "Mes-Año"=Fecha, "Establecimiento"="HOSPITAL DE NIÑOS ROBERTO DEL RÍO",
         "Código DEIS"="109101", "PM GRD 2021"="", "Gasto RRHH 2021"=`Gasto RRHH 2021`,"Producción 2021"=`Producción 2021`,
         "Costo por Actividad 2021"= round(`Gasto RRHH 2021`/`Producción 2021`)) %>% 
  select(Cod, Trazadora, `Mes-Año`, Establecimiento, `Código DEIS`, `PM GRD 2021`, `Gasto RRHH 2021`, `Producción 2021`,`Costo por Actividad 2021`)

# Hospitalizado -----------------------------------------------------------
i1 <- Cubo_9 %>% filter((CC %in% hospitalizacion | CC %in% hospitalizacion_qx | CC %in% hospitalizacion_uci) & Item=="Total RRHH")  %>% 
  group_by(Fecha) %>% summarise("Gasto RRHH 2021" = sum(total))
p1 <- Cubo_9 %>% filter(CC %in% hospitalizacion & Item=="p1")  %>% group_by(Fecha) %>% summarise("Producción 2021" = sum(total))
p11 <-  Cubo_9 %>% filter(CC %in% hospitalizacion_uci & Item=="p3")  %>% group_by(Fecha) %>% summarise("Producción 2021" = sum(total))
p1 <- data.frame(Fecha=p1$Fecha, "Producción 2021"= p1$`Producción 2021`+p11$`Producción 2021`)
colnames(p1)[2] <- "Producción 2021"
i1 <- inner_join(i1,p1) %>% 
  mutate("Cod"=1, "Trazadora"="Hospitalización", "Mes-Año"=Fecha, "Establecimiento"="HOSPITAL DE NIÑOS ROBERTO DEL RÍO",
         "Código DEIS"="109101", "PM GRD 2021"= PM_GRD, "Gasto RRHH 2021"=`Gasto RRHH 2021`,"Producción 2021"=`Producción 2021`,
         "Costo por Actividad 2021"= round((`Gasto RRHH 2021`/(`Producción 2021`*PM_GRD)))) %>% 
  select(Cod, Trazadora, `Mes-Año`, Establecimiento, `Código DEIS`, `PM GRD 2021`, `Gasto RRHH 2021`, `Producción 2021`,`Costo por Actividad 2021`)

informe <- rbind(i1, i3, i2, i4)

openxlsx::write.xlsx(informe,paste0(ruta_base,"BBDD Produccion/PERC/PERC 2021/informe_mensual.xlsx"), 
                     colNames = TRUE, sheetName = "Informe", overwrite = TRUE)


# rm(i1, i2, i3, i4, p1,p11, p2, p3, p33, p4, Cubo_9, informe)