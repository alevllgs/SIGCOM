library(readxl)
library(tidyverse)


mes_archivo <- "06 Junio"
ruta_base <- "C:/Users/control.gestion3/OneDrive/"
resto <- "BBDD Produccion/PERC/PERC 2022/"



f_amb <- janitor::clean_names(read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/06 f_ambulatoria.xlsx")))
f_cron <- janitor::clean_names(read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/07 f_cronicos.xlsx")))
f_hosp <- janitor::clean_names(read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/08 f_hospitalizados.xlsx")))
f_rec <- janitor::clean_names(read_excel(paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/09 f_receton.xlsx")))

M2_Pab_EqMed <- (paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/89_Pabellon.xlsx"))
M2 <- (paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/03 M2.xlsx"))



f_rec$folio <- row.names(f_rec)

f_rec <- f_rec  %>% mutate(folio=folio, servicio=servicio_receton, valorizacion=valor_total, tipo_pac ="REC") %>% 
  select(folio, servicio, valorizacion, tipo_pac) %>% 
  filter(servicio != "AJUSTE (BAJA) INVENTARIO" &
           servicio != "BAJA POR ROTURAS Y OTROS" &
           servicio != "SECCION PRODUCCION FARMACIA" &
           servicio != "PRESTAMO" &
           servicio != "ERROR DE INGRESO" &
           servicio != "BAJA POR VENCIMIENTO")

farmacia <- rbind(f_amb, f_cron, f_hosp) %>% select(folio, servicio, valorizacion, tipo_pac)

farmacia <- rbind(f_rec, farmacia)
rm(f_amb, f_cron, f_hosp, f_rec)

farmacia$servicio <- replace(farmacia$servicio, grep("GASTO GENERAL LACTANTES", farmacia$servicio), "GASTO GENERAL LACTANTES")

farmacia <- farmacia %>%  select (-tipo_pac) %>%  mutate(folio = folio, valorizacion = as.numeric(valorizacion), 
  perc = case_when(servicio=="U.PEDIATRIA GRAL B"~"116-HOSPITALIZACIÓN PEDIATRÍA",
             servicio=="UNIDAD CUIDADOS INTENSIVOS"~"170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA",
             servicio=="U.P.C.C.V"~"198-UNIDAD DE TRATAMIENTO INTENSIVO CORONARIOS",
             servicio=="UNIDAD TRATAMIENTO INTENSIVO"~"196-UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA",
             servicio=="ONCOLOGIA"~"87-HOSPITALIZACIÓN ONCOLOGÍA",
             servicio=="CIRUGIA GENERAL"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="U.PEDIATRIA GRAL C -AISLAMIENT"~"116-HOSPITALIZACIÓN PEDIATRÍA",
             servicio=="U.PEDIATRIA GRAL A"~"116-HOSPITALIZACIÓN PEDIATRÍA",
             servicio=="PLASTICA Y QUEMADOS"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="SALA TRANSICION UTI"~"170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA",
             servicio=="ORTOPEDIA Y TRAUMATOLOGIA"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="URGENCIA(AMBULATORIA)"~"15302-CONSULTA PEDIATRÍA GENERAL",
             servicio=="PABELLON QUIRURGICO"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="AT.ASISTENTE SOCIAL"~"99544-TRABAJO SOCIAL",
             servicio=="POLICLINICO CIRUGIA GRAL."~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="GINECOLOGIA"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="OTORRINOLARINGOLOGIA"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="SALUD MENTAL CE"~"149-HOSPITALIZACIÓN PSIQUIATRÍA",
             servicio=="SALUD MENTAL ME"~"149-HOSPITALIZACIÓN PSIQUIATRÍA",
             servicio=="UROLOGIA"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="MEDICINA"~"116-HOSPITALIZACIÓN PEDIATRÍA",
             servicio=="PREMATUROS"~"116-HOSPITALIZACIÓN PEDIATRÍA",
             servicio=="CENTRAL DE PROCEDIMIENTOS"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="TRAUMATOLOGIA Y ORTOPEDIA"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="TRIPLETA SERVICIO"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="UNIDAD TRATAMIENTO INTERMEDIO"~"196-UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA",
             servicio=="U. CUIDADO INT. CARDIOVASCULAR"~"177-UNIDAD DE CUIDADOS CORONARIOS",
             servicio=="UNIDAD DE CUIDADOS INTENSIVOS"~"170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA",
             servicio=="U.PEDIATRIA GRAL C -AISLAMIENT"~"116-HOSPITALIZACIÓN PEDIATRÍA",
             servicio=="U.PEDIATRIA GRAL B"~"116-HOSPITALIZACIÓN PEDIATRÍA",
             servicio=="SALA TRANSICION UTI"~"196-UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA",
             servicio=="ORTOPEDIA Y TRAUMATOLOGIA"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="CIRUGIA GENERAL"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="ONCOLOGIA"~"87-HOSPITALIZACIÓN ONCOLOGÍA",
             servicio=="U.PEDIATRIA GRAL A"~"116-HOSPITALIZACIÓN PEDIATRÍA",
             servicio=="PLASTICA Y QUEMADO"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="PABELLON QUIRURGICO"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="SALUD MENTAL CORTA ESTADIA"~"149-HOSPITALIZACIÓN PSIQUIATRÍA",
             servicio=="UNIDAD TRATAMIENTO INTERMEDIO"~"196-UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA",
             servicio=="UNIDAD DE CUIDADOS INTENSIVOS"~"170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA",
             servicio=="U. CUIDADO INT. CARDIOVASCULAR"~"177-UNIDAD DE CUIDADOS CORONARIOS",
             servicio=="CIRUGIA GENERAL"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="ONCOLOGIA"~"87-HOSPITALIZACIÓN ONCOLOGÍA",
             servicio=="U.PEDIATRIA GRAL C -AISLAMIENT"~"116-HOSPITALIZACIÓN PEDIATRÍA",
             servicio=="U.PEDIATRIA GRAL A"~"116-HOSPITALIZACIÓN PEDIATRÍA",
             servicio=="ORTOPEDIA Y TRAUMATOLOGIA"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="PLASTICA Y QUEMADO"~"90-HOSPITALIZACIÓN QUIRÚRGICA",
             servicio=="U.PEDIATRIA GRAL B"~"116-HOSPITALIZACIÓN PEDIATRÍA",
             servicio=="SALA TRANSICION UTI"~"170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA",
             servicio=="CONSULTORIO INFECTOLOGIA"~"15113-CONSULTA INFECTOLOGÍA",
             servicio=="REUMATOLOGIA"~"15104-CONSULTA REUMATOLOGÍA",
             servicio=="ONCOLOGIA CAE"~"15135-CONSULTA HEMATOLOGÍA ONCOLÓGICA",
             servicio=="GASTROENTEROLOGIA"~"15119-CONSULTA GASTROENTEROLOGÍA",
             servicio=="NEUROLOGIA"~"15305-CONSULTA NEUROLOGÍA PEDIÁTRICA",
             servicio=="BRONCOPULMONAR"~"15111-CONSULTA NEUMOLOGÍA",
             servicio=="URGENCIA(AMBULATORIA)"~"15302-CONSULTA PEDIATRÍA GENERAL",
             servicio=="NUTRIOLOGOS"~"15008-CONSULTA NUTRICIÓN",
             servicio=="HEMOFILICOS CAE"~"15135-CONSULTA HEMATOLOGÍA ONCOLÓGICA",
             servicio=="NEFROLOGIA"~"15114-CONSULTA NEFROLOGÍA",
             servicio=="UROLOGIA"~"15203-CONSULTA UROLOGÍA",
             servicio=="PEDIATRIA-NANEAS"~"15302-CONSULTA PEDIATRÍA GENERAL",
             servicio=="CARDIOLOGIA"~"15105-CONSULTA CARDIOLOGÍA",
             servicio=="POLICLINICO CIRUGIA GRAL."~"15409-CONSULTA CIRUGÍA PEDIÁTRICA",
             servicio=="PREMATUROS"~"15409-CONSULTA CIRUGÍA PEDIÁTRICA",
             servicio=="ENDOCRINOLOGIA"~"15110-CONSULTA ENDOCRINOLOGÍA",
             servicio=="QUEMADOS"~"15208-CONSULTA CIRUGÍA PLÁSTICA",
             servicio=="HEMATOLOGIA"~"15135-CONSULTA HEMATOLOGÍA ONCOLÓGICA",
             servicio=="ANESTESIA"~"15302-CONSULTA PEDIATRÍA GENERAL",
             servicio=="M.FISICA Y REHABILITACION"~"15118-CONSULTA FISIATRÍA",
             servicio=="CENTRAL DE PROCEDIMIENTOS"~"473-QUIRÓFANOS MENOR AMBULATORIA",
             servicio=="GINECOLOGIA"~"15502-CONSULTA GINECOLOGICA",
             servicio=="SALUD MENTAL"~"15109-CONSULTA PSIQUIATRÍA",
             servicio=="DENTAL"~"15602-CONSULTA ODONTOLOGÍA",
             servicio=="TRAUMATOLOGIA Y ORTOPEDIA"~"15316-CONSULTA TRAUMATOLOGÍA PEDIÁTRICA",
             servicio=="OFTALMOLOGIA"~"15209-CONSULTA OFTALMOLOGÍA",
             servicio=="OTORRINOLARINGOLOGIA"~"15211-CONSULTA OTORRINOLARINGOLOGÍA",
             servicio=="MAXILOFACIAL"~"15602-CONSULTA ODONTOLOGÍA",
             servicio=="DERMATOLOGIA"~"15106-CONSULTA DERMATOLOGÍA",
             servicio=="CAE SEGUIMIENTO"~"15302-CONSULTA PEDIATRÍA GENERAL",
             servicio=="PLASTICA"~"15208-CONSULTA CIRUGÍA PLÁSTICA",
             servicio=="NEUROCIRUGIA"~"15121-CONSULTA NEUROCIRUGÍA",
             servicio=="FONOAUDIOLOGIA"~"15302-CONSULTA PEDIATRÍA GENERAL",
             servicio=="GENETICA"~"15115-CONSULTA GENÉTICA",
             servicio=="CONSUMO GENERAL C.ROSARIO"~"116-HOSPITALIZACIÓN PEDIATRÍA",
             servicio=="CONSUMO GENERAL DE POLI CIRUGIA"~"15409-CONSULTA CIRUGÍA PEDIÁTRICA",
             servicio=="CONSUMO GENERAL ESPECIALIDADES"~"CAE Prorratear",
             servicio=="CONSUMO GENERAL IMAGENOLOGIA"~"542-IMAGENOLOGÍA",
             servicio=="CONSUMO GENERAL PABELLON"~"Pabellon prorratear",
             servicio=="CONSUMO GENERAL POLI BRONCOLOGIA"~"15111-CONSULTA NEUMOLOGÍA",
             servicio=="CONSUMO GENERAL POLI DE PROCEMIENTOS"~"473-QUIRÓFANOS MENOR AMBULATORIA",
             servicio=="CONSUMO GENERAL POLI DERMATOLOGIA"~"15106-CONSULTA DERMATOLOGÍA",
             servicio=="CONSUMO GENERAL S. DE ONCOLOGIA"~"15135-CONSULTA HEMATOLOGÍA ONCOLÓGICA",
             servicio=="CONSUMO GENERAL S.CIRUGIA SAN JOSE"~"471-QUIRÓFANOS MAYOR AMBULATORIA",
             servicio=="CONSUMO GENERAL SERVICIO URGENCIA"~"216-EMERGENCIAS PEDIÁTRICAS",
             servicio=="CONSUMO GENERAL U.C.E."~"662-CENTRAL DE ESTERILIZACIÓN",
             servicio=="SERVICIO DE ESTERILIZACION"~"662-CENTRAL DE ESTERILIZACIÓN",
             servicio=="CONSUMO GENERAL URACI"~"567-REHABILITACIÓN",
             servicio=="CONSUMO GRAL. DE C. HEMOFILICO"~"87-HOSPITALIZACIÓN ONCOLOGÍA",
             servicio=="CONSUMO GRAL. DE POLI-BANCO DE SANGRE"~"575-BANCO DE SANGRE",
             servicio=="ANATOMIA PATOLOGICA"~"544-ANATOMÍA PATOLÓGICA",
             servicio=="CONSUMO GRAL. LABORATORIO CENTRAL"~"518-LABORATORIO CLÍNICO",
             servicio=="CONSUMO GRAL. OTORRINOLARINGOLOGIA"~"15211-CONSULTA OTORRINOLARINGOLOGÍA",
             servicio=="CONSUMO GRAL. SERV. NEFROLOGIA"~"15114-CONSULTA NEFROLOGÍA",
             servicio=="CONSUMO GRAL. UCI CARDIOLOGICA"~"177-UNIDAD DE CUIDADOS CORONARIOS",
             servicio=="CONSUMO NANEAS"~"15302-CONSULTA PEDIATRÍA GENERAL",
             servicio=="GASTO GENERAL AISLAMIENTO"~"15302-CONSULTA PEDIATRÍA GENERAL",
             servicio=="GASTO GENERAL NEUROLOGIA CAE"~"15305-CONSULTA NEUROLOGÍA PEDIÁTRICA",
             servicio=="GASTO GENERAL SALUD MENTAL HOSP."~"149-HOSPITALIZACIÓN PSIQUIATRÍA",
             servicio=="GASTOS CAE"~"CAE Prorratear",
             servicio=="GASTOS GENERALES DE ELECTROENCEFALOGRAFIA"~"15305-CONSULTA NEUROLOGÍA PEDIÁTRICA",
             servicio=="ELECTROENCEFALOGRAMA"~"15305-CONSULTA NEUROLOGÍA PEDIÁTRICA",
             servicio=="POLICLINICO DE CARDIOCIRUGIA"~"15105-CONSULTA CARDIOLOGÍA",
             servicio=="SERVICIO DE URGENCIA"~"216-EMERGENCIAS PEDIÁTRICAS",
             servicio=="SERVICIO DENTAL CAE"~"15602-CONSULTA ODONTOLOGÍA",
             servicio=="SERVICIO POLI-OFTALMOLOGIA"~"15209-CONSULTA OFTALMOLOGÍA",
             servicio=="GASTO GENERAL LACTANTES"~"15302-CONSULTA PEDIATRÍA GENERAL",
             servicio=="ODONTOLOGIA(DENTAL)"~"15602-CONSULTA ODONTOLOGÍA",
             servicio=="SALUD MENTAL MEDIANA ESTADIA"~"149-HOSPITALIZACIÓN PSIQUIATRÍA",
             servicio=="ORTODONCIA"~"15602-CONSULTA ODONTOLOGÍA",
             
             servicio=="CONSUMO GENERAL DERMATOLOGIA CAE"~"15106-CONSULTA DERMATOLOGÍA",
             servicio=="CONSUMO GRAL. ORTOP. Y TRAUMA"~"15316-CONSULTA TRAUMATOLOGÍA PEDIÁTRICA",
             servicio=="GASTO GENERAL SALUD MENTAL CAE"~"15109-CONSULTA PSIQUIATRÍA",
             servicio=="UCI CARDIOVASCULAR"~"177-UNIDAD DE CUIDADOS CORONARIOS",
             servicio=="SERV. UCI CARDIOVASCULAR"~"177-UNIDAD DE CUIDADOS CORONARIOS",
             servicio=="S.UNIDAD DE CUIDADOS INTENSIVO"~"170-UNIDAD DE CUIDADOS INTENSIVOS PEDIATRIA",
             servicio=="S.PEDIATRIA GRAL A"~"116-HOSPITALIZACIÓN PEDIATRÍA",
             servicio=="S.PEDIATRIA GRAL B"~"116-HOSPITALIZACIÓN PEDIATRÍA",
             servicio=="UD PEDIATRICA GENERAL D"~"116-HOSPITALIZACIÓN PEDIATRÍA",
             servicio=="S.PEDIATRIA GRAL C -AISLAMIENT"~"116-HOSPITALIZACIÓN PEDIATRÍA",
             servicio=="GASTO GENERAL SERVICIO ESTERILIZACION"~"662-CENTRAL DE ESTERILIZACIÓN",
             
             servicio=="CONSUMO PABELLON CARDIOLOGIA"~"464-QUIRÓFANOS CARDIOVASCULAR",
             servicio=="GASTO GENERAL UTI 2º PISO"~"196-UNIDAD DE TRATAMIENTO INTENSIVO PEDÍATRICA",
             servicio=="PROGRAMA MINSAL IH H1N1"~"15113-CONSULTA INFECTOLOGÍA",
             servicio=="ODONTOPEDIATRIA"~"15602-CONSULTA ODONTOLOGÍA",
             servicio=="NUTRICIONISTA"~"15008-CONSULTA NUTRICIÓN",
             servicio=="CONS. ENFERMEDADES INFECCIOSAS"~"15113-CONSULTA INFECTOLOGÍA",

             TRUE ~ "Asignar CC"
))

No_asignado_farmacia <- farmacia %>% filter(perc == "Asignar CC")

prescripciones <- farmacia %>% select(perc, folio) %>% 
  group_by(perc) %>% 
  mutate(prescripciones = 1) %>%  select(perc,prescripciones) %>% 
  summarise(prescripciones=sum(prescripciones)) %>% 
  ungroup() 


recetas <- distinct(farmacia)
recetas <- recetas %>% select(perc, folio) %>% 
  group_by(perc) %>% 
  mutate(recetas = 1) %>%  select(perc,recetas) %>% 
  summarise(recetas=sum(recetas)) %>% 
  ungroup() 


# prorrateo pabellón ------------------------------------------------------


M2 <- read_excel(M2)
M2Pab <- read_excel(M2_Pab_EqMed) %>% filter(SIGCOM != "Total")
M2Pab <- mutate_all(M2Pab, ~replace(., is.na(.), 0))
Metros_pabellon <- 11*45

"473-QUIRÓFANOS MENOR AMBULATORIA" <- sum(M2Pab$`473-QUIRÓFANOS MENOR AMBULATORIA`)
"471-QUIRÓFANOS MAYOR AMBULATORIA" <- sum(M2Pab$`471-QUIRÓFANOS MAYOR AMBULATORIA`)

M2Pab <- M2Pab %>% select(SIGCOM, `Distribución cirugias Electivas`) %>% 
  group_by(SIGCOM) %>% 
  summarise("Distribución cirugias Electivas" =sum(`Distribución cirugias Electivas`)) %>% 
  ungroup()

df <- tibble(SIGCOM= as.character(c("473-QUIRÓFANOS MENOR AMBULATORIA", "471-QUIRÓFANOS MAYOR AMBULATORIA")), 
             "Distribución cirugias Electivas"= c(`473-QUIRÓFANOS MENOR AMBULATORIA`, `471-QUIRÓFANOS MAYOR AMBULATORIA`))

M2Pab <- rbind(M2Pab, df)

M2Pab$Area <- "Quirofanos"

M2Pab <- M2Pab %>% mutate(Area = Area, CC = SIGCOM, 
                          M2=`Distribución cirugias Electivas`/sum(`Distribución cirugias Electivas`)*Metros_pabellon) %>% 
  select(Area, CC, M2)

M2 <- M2 %>% filter(Area != "Quirofanos")
M2 <- rbind(M2, M2Pab)

M2$prop <- M2$M2/sum(M2$M2) #asigna proporción a los M2

CAE_prorratear <- M2 %>% filter(Area == "Consultas" | Area == "Procedimientos")
CAE_prorratear$prop <- CAE_prorratear$M2/sum(CAE_prorratear$M2)

M2Pab$prop <- M2Pab$M2/sum(M2Pab$M2)


GG44 <- data.frame(
  "servicio" = "eliminar",
  "folio" = 0,
  "valorizacion" = 0
  )

farmacia3 <- GG44


qx <- c("464-QUIRÓFANOS CARDIOVASCULAR",
        "467-QUIRÓFANOS DIGESTIVA",
        "475-QUIRÓFANOS NEUROCIRUGÍA",
        "478-QUIRÓFANOS OFTALMOLOGÍA",
        "480-QUIRÓFANOS OTORRINOLARINGOLOGÍA",
        "485-QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA",
        "486-QUIRÓFANOS UROLOGÍA",
        "493-QUIRÓFANOS CIRUGÍA PLÁSTICA",
        "495-QUIRÓFANOS CIRUGÍA VASCULAR",
        "473-QUIRÓFANOS MENOR AMBULATORIA",
        "471-QUIRÓFANOS MAYOR AMBULATORIA")


for (i in qx) {
  q <- sum(ifelse(M2Pab$CC == i, M2Pab$prop, 0))
  GG2 <- farmacia %>% filter(perc=="Pabellon prorratear") %>% 
    summarise(servicio = i,
              folio = folio,
              valorizacion = valorizacion*q)
  GG44 <- rbind(GG44, GG2) %>% filter(servicio!="eliminar")
}



am <- c("15409-CONSULTA CIRUGÍA PEDIÁTRICA",
        "15008-CONSULTA NUTRICIÓN",
        "15104-CONSULTA REUMATOLOGÍA",
        "15105-CONSULTA CARDIOLOGÍA",
        "15106-CONSULTA DERMATOLOGÍA",
        "15109-CONSULTA PSIQUIATRÍA",
        "15110-CONSULTA ENDOCRINOLOGÍA",
        "15111-CONSULTA NEUMOLOGÍA",
        "15113-CONSULTA INFECTOLOGÍA",
        "15114-CONSULTA NEFROLOGÍA",
        "15115-CONSULTA GENÉTICA",
        "15118-CONSULTA FISIATRÍA",
        "15119-CONSULTA GASTROENTEROLOGÍA",
        "15121-CONSULTA NEUROCIRUGÍA",
        "15125-CONSULTA ANESTESIOLOGIA",
        "15135-CONSULTA HEMATOLOGÍA ONCOLÓGICA",
        "15203-CONSULTA UROLOGÍA",
        "15208-CONSULTA CIRUGÍA PLÁSTICA",
        "15209-CONSULTA OFTALMOLOGÍA",
        "15211-CONSULTA OTORRINOLARINGOLOGÍA",
        "15302-CONSULTA PEDIATRÍA GENERAL",
        "15305-CONSULTA NEUROLOGÍA PEDIÁTRICA",
        "15316-CONSULTA TRAUMATOLOGÍA PEDIÁTRICA",
        "15502-CONSULTA GINECOLOGICA",
        "15602-CONSULTA ODONTOLOGÍA",
        "359-TELEMEDICINA")



for (i in am) {
  a <- sum(ifelse(CAE_prorratear$CC == i, CAE_prorratear$prop, 0))
  GG2 <- farmacia %>% filter(perc=="Cae Prorratear") %>% 
    summarise(servicio = i,
              folio = folio,
              valorizacion = valorizacion*a)
  farmacia3 <- rbind(farmacia3, GG2) %>% filter(servicio!="eliminar")
}


farmacia3 <- rbind(farmacia3,GG44)


farmacia <- farmacia %>%  select(perc, folio, valorizacion) %>% filter(perc != "Pabellon prorratear" & perc != "CAE Prorratear")

farmacia3 <- farmacia3 %>%  mutate(perc = servicio) %>%  select(-servicio) #Da error
farmacia <- rbind(farmacia, farmacia3)

prescripciones <- farmacia %>% select(perc, folio) %>% 
  group_by(perc) %>% 
  mutate(prescripciones = 1) %>%  select(perc,prescripciones) %>% 
  summarise(prescripciones=sum(prescripciones)) %>% 
  ungroup() 


recetas <- distinct(farmacia)
recetas <- recetas %>% select(perc, folio) %>% 
  group_by(perc) %>% 
  mutate(recetas = 1) %>%  select(perc,recetas) %>% 
  summarise(recetas=sum(recetas)) %>% 
  ungroup() 


gasto_farmacia <- farmacia %>% select(perc, valorizacion) %>% 
  group_by(perc) %>% 
  summarise(gasto=sum(valorizacion)) %>% 
  ungroup() 


prop <- sum(gasto_farmacia$gasto)
gasto_farmacia$gasto <- gasto_farmacia$gasto/prop

farmacia_perc <- inner_join(prescripciones, recetas)

rm(df,prop, GG2, GG44, farmacia3, M2, M2_Pab_EqMed, M2Pab, CAE_prorratear, 
   `471-QUIRÓFANOS MAYOR AMBULATORIA`, `473-QUIRÓFANOS MENOR AMBULATORIA`, a,  
   am, Metros_pabellon, q, qx, prescripciones, recetas, farmacia)

colnames(farmacia_perc)[1] <- "PERC ASOCIADO"
colnames(farmacia_perc)[2] <- "593_2-SERVICIO FARMACEUTICO | Prescripción"
colnames(farmacia_perc)[3] <- "593_1-SERVICIO FARMACEUTICO | Receta"

openxlsx::write.xlsx(farmacia_perc,paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/901_Farmacia.xlsx"), overwrite = T)
openxlsx::write.xlsx(gasto_farmacia,paste0(ruta_base,resto,mes_archivo,"/Insumos de Informacion/900_gasto_farmacia.xlsx"), overwrite = T)






