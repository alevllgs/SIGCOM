library(tidyverse)
library(readxl)
library(lubridate)
library(janitor)
library(dplyr)
library(openxlsx)
library(xlsx)
library(readxl)

dias_mes <- 20
mes <- "02"
anio <- "2023"

ruta_base <- "C:/Users/control.gestion3/OneDrive/BBDD Produccion/PERC/PERC "
mes_completo <- c("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre")
mes_completo <- mes_completo[as.numeric(mes)]
empleados <- janitor::clean_names(read_excel(paste0(ruta_base,anio,"/",mes," ",mes_completo,"/Insumos de Informacion/11 Empleados mes.xlsx")))
pt <- janitor::clean_names(read_excel(paste0(ruta_base,anio,"/Insumos de info anual/12 Programacion Total.xlsx")))
M2Pab <- paste0(ruta_base,anio,"/",mes," ",mes_completo,"/Insumos de Informacion/89_Pabellon.xlsx")
M2 <- read_excel(paste0(ruta_base,anio,"/Insumos de info anual/M2.xlsx"))
cae_prorratear <- paste0(ruta_base,anio,"/",mes," ",mes_completo,"/Insumos de Informacion/03 M2.xlsx")

directorio <- paste0("C:/Users/control.gestion3/OneDrive/BBDD Produccion/PERC/PERC ",anio,"/",mes," ",mes_completo,"/Complemento Subir")

dir.create(directorio)


#esta secuencia sirve para eliminar errores con los rut -k,  
#los cuales los deja en minuscula
empleados$run <- substr(empleados$identificacion,1,nchar(empleados$identificacion)-2)
empleados$sep2 <- substr(empleados$identificacion,9,nchar(empleados$identificacion)-0)
empleados$sep3 <- substr(empleados$sep2,2,nchar(empleados$sep2)-0)
empleados$dv <- ifelse(empleados$sep3 != "", empleados$sep3, empleados$sep2)
empleados$dv <- ifelse(empleados$dv == "K", "k", empleados$dv)
empleados$identificacion <- paste(empleados$run,empleados$dv,sep="-")

# Planilla Empleados ------------------------------------------------------
# nombres sirve para eliminar los nombres duplicados por escritura distinta

nombres <-  empleados %>% select(identificacion, nombre, categoria_de_empleado)
nombres <- unique.array(nombres)
nombres$duplicados <- duplicated(nombres$identificacion)
nombres <- nombres %>% 
  filter(duplicados == FALSE)

empleados <-  merge(x = empleados, y = nombres, 
                by = "identificacion")

colnames(empleados)[21] <- "Nombre"
colnames(empleados)[1] <- "Identificación"
colnames(empleados)[22] <- "categoria_de_empleado"

empleados <- empleados %>% mutate("Categoría de Empleado" = case_when(
  #00102 Medico Especialista
  categoria_de_empleado=="MEDICO CIRUJANO"~"00102",
  categoria_de_empleado=="MEDICO TRAUMATOLOGICO Y ORTOPEDIA"~"00102", 
  categoria_de_empleado=="CIRUJANO INFANTIL"~"00102",
  categoria_de_empleado=="NEUROCIRUJANO"~"00102",
  categoria_de_empleado=="PEDIATRIA"~"00102",
  categoria_de_empleado=="OFTALMOLOGIA"~"00102",
  categoria_de_empleado=="RAYOS"~"00102",
  categoria_de_empleado=="MED.INTEGRAL"~"00102",
  categoria_de_empleado=="MEDICO FISIATRA"~"00102",
  categoria_de_empleado=="ANESTESISTA"~"00102",
  categoria_de_empleado=="PERIODO ASISTENCIAL OBLIGATORIO (PAO)"~"00102",
  categoria_de_empleado=="DERMATOLOGIA"~"00102",
  categoria_de_empleado=="ANESTESIOLOGIA"~"00102",
  categoria_de_empleado=="CARDIOLOGIA"~"00102",
  categoria_de_empleado=="NEUROLOGIA"~"00102",
  categoria_de_empleado=="NEUROCIRUJANOS"~"00102",
  categoria_de_empleado=="CIRUGIA MAXILO FACIAL"~"00102",
  categoria_de_empleado=="CIRUGIA CARDIACA"~"00102",
  categoria_de_empleado=="M.OBSTETRICIA Y GINECOLOGIA"~"00102",
  categoria_de_empleado=="MEDICO TRAMATOLOGO Y ORTOPEDIA"~"00102",
  categoria_de_empleado=="MEDICO PSIQUIATRA"~"00102",
  categoria_de_empleado=="OTORRINO"~"00102",
  categoria_de_empleado=="ANATOMO PATOLOGO"~"00102",
  categoria_de_empleado=="CIRUGIA"~"00102",
  categoria_de_empleado=="CIRUGIA INFANTIL"~"00102",
  categoria_de_empleado=="PSIQUIATRIA INFANTIL"~"00102",
  categoria_de_empleado=="NEURORADIOLOGIA"~"00102",
  categoria_de_empleado=="RADIOLOGIA"~"00102",
  categoria_de_empleado=="BECADOS PRIMARIOS"~"00102",
  categoria_de_empleado=="OTORRINOLARINGOLOGIA"~"00102",
  categoria_de_empleado=="ONCOLOGIA"~"00102",
  categoria_de_empleado=="GASTROENTEROLOGIA"~"00102",
  categoria_de_empleado=="RADIOLOGIA PEDIATRICA"~"00102",
  categoria_de_empleado=="TRAUMATOLOGIA Y ORTOPEDIA"~"00102",
  #00103 Medico General
  categoria_de_empleado=="MEDICOS"~"00103",
  #00302 Profesional en Salud
  categoria_de_empleado=="TECNOLOGO MEDICO"~"00302",
  categoria_de_empleado=="KINESIOLOGO"~"00302",
  categoria_de_empleado=="KINESIOLOGIA"~"00302",
  categoria_de_empleado=="ENFERMERA"~"00302",
  categoria_de_empleado=="EMFERMERA"~"00302",
  categoria_de_empleado=="TERAPEUTA OCUPACIONAL"~"00302",
  categoria_de_empleado=="PSICOLOGOS"~"00302",
  categoria_de_empleado=="NUTRICIONISTA"~"00302",
  categoria_de_empleado=="PSICOLOGO (A)"~"00302",
  categoria_de_empleado=="PSICOLOGO"~"00302",
  categoria_de_empleado=="FONOAUDIOLOGO (A)"~"00302",
  categoria_de_empleado=="TECNOLOGO (A) MEDICO"~"00302",
  categoria_de_empleado=="FONOAUDILOGO"~"00302",
  #00305 Odontologos
  categoria_de_empleado=="ODONTOLOGIA GENERAL NIÑOS"~"00305",
  categoria_de_empleado=="ODONTOGO"~"00305",
  categoria_de_empleado=="CIRUJANO DENTISTA"~"00305",
  categoria_de_empleado=="ODONTOLOGIA"~"00305",
  categoria_de_empleado=="DENTISTA CONSULTORIO"~"00305",
  #00309 Quimicos Farmaceuticos
  categoria_de_empleado=="QUIMICO FARMACEUTICO"~"00309",
  #00310 Bioquimicos
  categoria_de_empleado=="BIOQUIMICOS"~"00310",
  categoria_de_empleado=="BIOQUIMICO"~"00302",
  #00401 Tecnicos en Salud
  categoria_de_empleado=="TECNICO NIVEL SUPERIOR DE ENFERMERIA"~"00401",
  categoria_de_empleado=="TECNICO NIVEL SUPERIOR ENFERMERIA"~"00401",
  categoria_de_empleado=="TECNICO PARAMEDICO"~"00401",
  categoria_de_empleado=="TEC. NIV. SUPERIOR ENFERMERIA"~"00401",
  categoria_de_empleado=="TECNICO EN ALIMENTACION"~"00401",
  categoria_de_empleado=="TECNICO EN ALIMENTOS"~"00401",
  #00403 Otros tecnicos
  categoria_de_empleado=="TECNICO"~"00403",
  categoria_de_empleado=="TECNICO EN COMPUTACION E INFORMATICA"~"00403",
  categoria_de_empleado=="TECNICO EN MANTENCION DE EQUIPOS INDUSTRIALES"~"00403",
  categoria_de_empleado=="TECNICO DE PARVULOS"~"00403",
  categoria_de_empleado=="TECNICO EN ALIMENTO"~"00403",
  categoria_de_empleado=="TECNICO JURIDICO"~"00403",
  categoria_de_empleado=="TECNICO NIVEL SUPERIOR EN COMPUTACION"~"00403",
  categoria_de_empleado=="TECNICO NIVEL MEDIO EN ELECTRONICA"~"00403",
  categoria_de_empleado=="TECNICO EN FARMACIA"~"00403",
  categoria_de_empleado=="TECNICO DE FARMACIA"~"00403",
  categoria_de_empleado=="TECNICO NIVEL SUPERIOR"~"00403",
  categoria_de_empleado=="TECNICO EN COMPUTACION"~"00403",
  categoria_de_empleado=="TECNICO NIVEL SUPERIOR ANALISTA PROGRAMADOR"~"00403",
  categoria_de_empleado=="TECNICO EN MANTENCION"~"00403",
  categoria_de_empleado=="OTROS TECNICO"~"00403",
  categoria_de_empleado=="TECNICO NIVEL SUPERIOR EN TRABAJO SOCIAL"~"00403",
  categoria_de_empleado=="TECNICO NIVEL SUPERIOR EN ELECTRICIDAD"~"00403",
  categoria_de_empleado=="TECNICO EN MANTENCION EQUIPOS INDUSTRIALES"~"00403",
  categoria_de_empleado=="TECNICO NIVEL SUPERIOR "~"00403",
  categoria_de_empleado=="OTROS TECNICOS"~"00403",
  #00501 Auxiliares en Salud
  categoria_de_empleado=="AUXILIAR PARAMEDICO"~"00501",
  categoria_de_empleado=="AUXILIAR DE ENFERMERIA"~"00501",
  #00701 Personal Administrativo
  categoria_de_empleado=="ADMINISTRATIVOS"~"00701",
  categoria_de_empleado=="ADMINISTRATIVO"~"00701",
  #00702 Profesional Administrativo
  categoria_de_empleado=="INGENIERO CIVIL BIOMEDICO"~"00702",
  categoria_de_empleado=="INGENIERO EJECUCION EN INFORMATICA"~"00702",
  categoria_de_empleado=="INGENIERO (A) EN INFORMATICA"~"00702",
  categoria_de_empleado=="INGENIERO INDUSTRIAL"~"00702",
  categoria_de_empleado=="COMUNICADOR (A) AUDIOVISUAL"~"00702",
  categoria_de_empleado=="INGENIERO (A) EJECUCION EN INFORMATICA"~"00702",
  categoria_de_empleado=="EDUCADORA DE PARVULOS"~"00702",
  categoria_de_empleado=="ASISTENTE SOCIAL"~"00702",
  categoria_de_empleado=="CONTADOR"~"00702",
  categoria_de_empleado=="JEFE DEPTO. RECURSOS HUMANOS"~"00702",
  categoria_de_empleado=="JEFE SERV. ORIENTACION MEDICA Y ESTADIST"~"00702",
  categoria_de_empleado=="PERIODISTA"~"00702",
  categoria_de_empleado=="ADMINISTRADOR PUBLICO"~"00702",
  categoria_de_empleado=="INGENIERO (A) BIOMEDICO"~"00702",
  categoria_de_empleado=="COMUNICADOR (A) SOCIAL"~"00702",
  categoria_de_empleado=="EDUCADOR DE PARVULOS"~"00702",
  categoria_de_empleado=="INGENIERO (A) EN ADMINISTRACION DE RECURSOS HUMANOS"~"00702",
  categoria_de_empleado=="TRABAJADOR (A) SOCIAL"~"00702",
  categoria_de_empleado=="INGENIERO (A) CIVIL BIOMEDICO"~"00702",
  categoria_de_empleado=="CONSTRUCTOR CIVIL"~"00702",
  categoria_de_empleado=="CONSTRUCTOR (A) CIVIL"~"00702",
  categoria_de_empleado=="INGENIERO (A) EJECUCION EN ELECTRONICA"~"00702",
  categoria_de_empleado=="ABOGADO (A)"~"00702",
  categoria_de_empleado=="EQUIPOS MEDICOS"~"00702",
  categoria_de_empleado=="UNIDAD DE EQUIPOS INDUSTRIALES"~"00702",
  categoria_de_empleado=="PREVENCION DE RIESGO Y SALUD OCUPACIONAL"~"00702",
  categoria_de_empleado=="UNIDAD DE EQUIPOS INDUSTRIALES"~"00702",
  categoria_de_empleado=="INGENIERO (A) PREVENCION DE RIESGOS"~"00702",
  categoria_de_empleado=="CONTADOR (A) PUBLICO"~"00702",
  categoria_de_empleado=="INGENIERO (A) CONSTRUCTOR"~"00702",
  categoria_de_empleado=="INGENIERO CIVIL"~"00702",
  categoria_de_empleado=="INGENIERO (A) EN INDUSTRIA Y LOGISTICA"~"00702",
  categoria_de_empleado=="COMUNICADOR AUDIOVISUAL"~"00702",
  categoria_de_empleado=="PROFESIONALES UNIVERSITARIOS"~"00702",
  categoria_de_empleado=="ADMINISTRADOR (A) PUBLICO"~"00702",
  categoria_de_empleado=="CONTADOR (A) PUBLICO (A) AUDITOR"~"00702",
  categoria_de_empleado=="INGENIERO (A) CIVIL"~"00702",
  categoria_de_empleado=="INGENIERIA BIOMETRICA"~"00702",
  categoria_de_empleado=="JEFE DEPTO. FINANZAS"~"00702",
  
  #00705 Personal Directivo
  categoria_de_empleado=="DIRECTOR DE HOSPITAL"~"00705",
  #00710 Auxiliares
  categoria_de_empleado=="CHOFER"~"00710",
  categoria_de_empleado=="AUXILIAR"~"00710",
  TRUE ~ "Asignar Clasificacion"), 
  "Tipo de Contrato" = case_when(tipo_de_contrato == "HONORARIOS" ~ 2,
                                 tipo_de_contrato == "HONORARIO" ~ 2,
                                 TRUE ~ 1),
  "Niveles Laborales" = "00",
  "Bonificaciones" = 0,
  "Salario Base" = salario_base+mto_hrs_extras,
  "Beneficios Laborales" = beneficios_laborales)

empleados$`Tipo de Contrato` <- as.character(empleados$`Tipo de Contrato`)

#base es la planilla con todo el contenido que sirve para la planilla 2
base <- empleados %>% 
  select(Identificación, Nombre, `Salario Base`,`Categoría de Empleado`, 
         `Niveles Laborales`, Bonificaciones, `Beneficios Laborales`,
         `Tipo de Contrato`, cant_hrs_extras) %>% 
  group_by(Identificación,Nombre, `Categoría de Empleado`,`Niveles Laborales`, 
           `Tipo de Contrato`) %>% 
  summarise("Salario Base"=sum(`Salario Base`),
            "Bonificaciones"=sum(Bonificaciones),
            "Beneficios Laborales"= sum(`Beneficios Laborales`), 
            "Horas Extras" = sum(cant_hrs_extras)) %>% 
  filter(`Salario Base` > 0) %>% select(Identificación, Nombre, `Salario Base`,
                                        `Categoría de Empleado`, 
                                        `Niveles Laborales`, Bonificaciones, 
                                        `Beneficios Laborales`,
                                        `Tipo de Contrato`, `Horas Extras`)

planilla1 <- base %>% select(-`Horas Extras`)
planilla1$`Tipo de Contrato` <- as.numeric(planilla1$`Tipo de Contrato`)

# Planilla Programacion Total ---------------------------------------------
#programacion es el cruce de base con pt

programacion <-  merge(x = base, y = pt, 
                    by.x = "Identificación", by.y = "rut", all.x = TRUE)
programacion <- programacion %>% select(Identificación, Nombre, especialidad,
                                        `Horas Extras`,horas_asignadas, 
                                        unidad_local, perc, 
                                        percent_de_distribucion, horas_totales)

#Verifica si hay personal no programado
no_programados <- programacion
no_programados$no_prog <- is.na(no_programados$perc)

no_programados <- no_programados %>%  filter(no_prog == "TRUE") %>% 
  select(Identificación)

no_programados <- left_join(no_programados, empleados)

no_programados <- no_programados %>% 
  select(Identificación, Nombre, categoria_de_empleado, tipo_de_contrato, unidad, horas)

programacion$horas_mensuales <-((programacion$horas_totales/5)*dias_mes)*programacion$percent_de_distribucion +
  programacion$`Horas Extras`*programacion$percent_de_distribucion

programacion <- programacion %>% select(Identificación, Nombre, perc, horas_mensuales)

# Pabellon

M2Pab <- read_excel(M2Pab)
M2Pab <- M2Pab %>% 
  filter(SIGCOM != "464-QUIRÓFANOS CARDIOVASCULAR") %>% 
  mutate(Area = "Quirofanos", CC = SIGCOM, prop = prop.table(prop_total)) %>% 
  select(-SIGCOM, -prop_total) 

GG1 <- programacion %>% 
  filter(perc == "Pabellón Prorratear") %>% 
  mutate(H = 1, CC = "CC") %>% 
  filter(CC == "gatito") #Crea GG1 vacio


for (i in M2Pab$CC) {
  GG2 <- programacion %>% filter(perc == "Pabellón Prorratear") 
  prop_pab <- M2Pab %>% filter(CC == i)
  GG2$H <- GG2$horas_mensuales*prop_pab$prop
  GG2$CC <- i
  
  GG1 <- rbind(GG1, GG2)
}

programacion <- programacion %>% filter(perc != "Pabellón Prorratear")

GG1 <- GG1 %>% mutate("Identificación" = Identificación, "Nombre"= Nombre, 
                      "perc"=CC, "horas_mensuales"=H) %>% 
  select(Identificación, Nombre, perc, horas_mensuales)

programacion <- rbind(GG1, programacion)


# crea un prorrateo de UCI y UTI ------------------------------------------

upc <- programacion %>% 
  filter(perc == "170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA" | perc == "196-UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA")

uti <- M2 %>% filter(Area == "UPC") %>% mutate(M2 = prop.table(M2)) %>% filter(CC == "196-UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA")
uti <- upc %>%  mutate(perc = "196-UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA", horas_mensuales = upc$horas_mensuales*uti$M2)

uci <- M2 %>% filter(Area == "UPC") %>% mutate(M2 = prop.table(M2)) %>% filter(CC == "170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA")
uci <- upc %>%  mutate(perc = "170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA", horas_mensuales = upc$horas_mensuales*uci$M2)


upccv <- programacion %>% 
  filter(perc == "198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS" | perc == "177-UNIDAD DE CUIDADOS CORONARIOS")

uticv <- M2 %>% filter(Area == "UPC_cardio") %>% mutate(M2 = prop.table(M2)) %>% 
  filter(CC == "198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS")
uticv <- upccv %>%  mutate(perc = "198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS", horas_mensuales = upccv$horas_mensuales*uticv$M2)

ucicv <- M2 %>% filter(Area == "UPC_cardio") %>% mutate(M2 = prop.table(M2)) %>% filter(CC == "177-UNIDAD DE CUIDADOS CORONARIOS")
ucicv <- upccv %>%  mutate(perc = "177-UNIDAD DE CUIDADOS CORONARIOS", horas_mensuales = upccv$horas_mensuales*ucicv$M2)


programacion <- programacion %>% 
  filter(perc != "170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA" & perc != "196-UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA" & perc != "198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS" & perc != "177-UNIDAD DE CUIDADOS CORONARIOS")

programacion <- rbind(uci, uti, ucicv,uticv, programacion)



# CAE prorratear ----------------------------------------------------------
cae_prorratear <- read_excel(cae_prorratear)
cae_prorratear <- cae_prorratear %>% 
  filter(Area == "Ambulatorio") %>% 
  filter(CC != "15105 - CONSULTA CARDIOLOGÍA" & CC != "15109 - CONSULTA PSIQUIATRÍA" &
         CC != "15118 - CONSULTA FISIATRÍA" & CC != "15135 - CONSULTA HEMATOLOGÍA ONCOLÓGICA") %>% 
  mutate(prop = prop.table(prop))

GG1 <- programacion %>% filter(perc == "gatito")
for (i in cae_prorratear$CC) {
  GG2 <- programacion %>% filter(perc == "CAE prorratear") 
  prop_cae <- cae_prorratear %>% filter(CC == i)
  GG2$horas_mensuales <- GG2$horas_mensuales*prop_cae$prop
  GG2$perc <- i
  
  GG1 <- rbind(GG1, GG2)
}


programacion <-  rbind(GG1, programacion) %>% filter(perc != "CAE prorratear")
# Graba -------------------------------------------------------------------

openxlsx::write.xlsx(planilla1, paste0(ruta_base, anio,"/",mes," ",mes_completo,"/Insumos de Informacion/911_Planilla_1_RRHH.xlsx"), 
                     colNames = TRUE, sheetName = "P1", overwrite = TRUE)

openxlsx::write.xlsx(programacion, paste0(ruta_base, anio,"/",mes," ",mes_completo,"/Insumos de Informacion/912_SIRH_R.xlsx"),
                     colNames = TRUE, sheetName = "SIRH", overwrite = TRUE)

no_programados <- unique(no_programados)
openxlsx::write.xlsx(no_programados, paste0(ruta_base, anio,"/",mes," ",mes_completo,"/Insumos de Informacion/913_No_Programados.xlsx"),
                     colNames = TRUE, sheetName = "NP", overwrite = TRUE)

openxlsx::write.xlsx(planilla1,paste0(directorio,"/01.xlsx"), 
                     colNames = TRUE, sheetName = "1", overwrite = TRUE)


no_asignada_profesion <- empleados %>% filter(`Categoría de Empleado` == "Asignar Clasificacion")

if(length(no_asignada_profesion$proceso) > 0 |  length(no_programados$Nombre) > 0){
  beepr::beep(sound = 7)}


rm(df, GG1, GG2, M2Pab, prop_pab, nombres, e, M2_Pab_EqMed, Metros_pabellon, 
   `471-QUIRÓFANOS MAYOR AMBULATORIA`, `473-QUIRÓFANOS MENOR AMBULATORIA`, 
   dias_mes, base, uci, uti, ucicv, uticv)

rm(empleados, planilla1, programacion, pt, ruta_base, anio, mes)

