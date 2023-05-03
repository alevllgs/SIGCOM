library(tidyverse)
library(stringr)
library(pdftools)
library(tidyverse)
library(readxl)
library(lubridate)
library(janitor)
library(dplyr)
library(openxlsx)
library(xlsx)

anio <- "2023"
mes <- "03"
propocion_CMA <- 1.25 #proporcion de 1.5CMA = 1CNA
prop_urg <- 0.5 #proporcion con 50% de la urgencia a TMT y 50% a cirugia
prop_CME_a_CMA <- 0.5 #definir


# Rutas Automaticas -------------------------------------------------------
mes_completo <- c("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre")
mes_completo <- mes_completo[as.numeric(mes)]
Fecha_filtro <- paste0(anio,"-",mes,"-01")
archivoBS <-paste0("C:/Users/control.gestion3/OneDrive/BBDD Produccion/REM/Serie BS/",anio,"/",anio,"-",mes," REM serie BS.xlsx")
graba <-paste0("C:/Users/control.gestion3/OneDrive/BBDD Produccion/PERC/PERC ",anio,"/",mes," ",mes_completo,"/Insumos de Informacion/89_Pabellon.xlsx")
ruta_pdf <- paste0("C:/Users/control.gestion3/OneDrive/BBDD Produccion/PERC/PERC ",anio,"/",mes," ",mes_completo,"/Insumos de Informacion/88_Oferta_Pabellones.pdf")

# Producción Pabellones ---------------------------------------------------


#B_qx0 es un dataframe en blanco para reemplazar los que no tienen producción
B_qx0 <- data.frame("...1" = 0, "...2" = 0, "...3" = 0, "...4" = 0,"...5" = 0,
                    "...6" = 0, "...7" = 0, "...8" = 0, "...9" = 0, "...10" = 0,
                    "Fecha" = 0, `Centro de Producción` = 0, `Unidades de Producción` = 0, "Valor" = 0)
colnames(B_qx0)[12] <- "Centro de Producción"
colnames(B_qx0)[13] <- "Unidades de Producción"




B_qx1 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1410:X1410") 
B_qx1 <- B_qx1 %>%   add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "475__33016 - QUIRÓFANOS NEUROCIRUGÍA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx1$...1 + B_qx1$...10, .after = 13) 

if(length(B_qx1) < 14 ){
  B_qx1 <- B_qx0}

B_qx2 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1545:X1545") 
B_qx2 <- B_qx2 %>%   add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "462__33003 - QUIRÓFANOS CABEZA Y CUELLO", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx2$...1 + B_qx2$...10, .after = 13)

if(length(B_qx2) < 14 ){
  B_qx2 <- B_qx0}

B_qx3 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1727:X1727")  
B_qx3 <- B_qx3 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "462__33003 - QUIRÓFANOS CABEZA Y CUELLO", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx3$...1 + B_qx3$...10, .after = 13)

if(length(B_qx3) < 14 ){
  B_qx3 <- B_qx0}

B_qx4 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1791:X1791")  
B_qx4 <- B_qx4 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "462__33003 - QUIRÓFANOS CABEZA Y CUELLO", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx4$...1 + B_qx4$...10, .after = 13)
if(length(B_qx4) < 14 ){
  B_qx4 <- B_qx0}

B_qx5 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1865:X1865")  
B_qx5 <- B_qx5 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "493__33034 - QUIRÓFANOS CIRUGÍA PLÁSTICA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx5$...1 + B_qx5$...10, .after = 13)
if(length(B_qx5) < 14 ){
  B_qx5 <- B_qx0}

B_qx6 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1908:X1908")  
B_qx6 <- B_qx6 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "486__33027 - QUIRÓFANOS UROLOGÍA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx6$...1 + B_qx6$...10, .after = 13)
if(length(B_qx6) < 14 ){
  B_qx6 <- B_qx0}

B_qx7 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O2067:X2067")  
B_qx7 <- B_qx7 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "464__33005 - QUIRÓFANOS CARDIOVASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx7$...1 + B_qx7$...10, .after = 13)
if(length(B_qx7) < 14 ){
  B_qx7 <- B_qx0}

B_qx8 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O2166:X2166")  
B_qx8 <- B_qx8 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "484__33025 - QUIRÓFANOS TORACICA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx8$...1 + B_qx8$...10, .after = 13)
if(length(B_qx8) < 14 ){
  B_qx8 <- B_qx0}

B_qx9 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O2397:X2397")  
B_qx9 <- B_qx9 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "484__33025 - QUIRÓFANOS TORACICA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx9$...1 + B_qx9$...10, .after = 13) #Abdominal
if(length(B_qx9) < 14 ){
  B_qx9 <- B_qx0}

B_qx10 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2437:X2437")  
B_qx10 <- B_qx10 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "484__33025 - QUIRÓFANOS TORACICA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx10$...1 + B_qx10$...10, .after = 13) #Procto
if(length(B_qx10) < 14 ){
  B_qx10 <- B_qx0}

B_qx11 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2560:X2560")  
B_qx11 <- B_qx11 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "486__33027 - QUIRÓFANOS UROLOGÍA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx11$...1 + B_qx11$...10, .after = 13) #URO
if(length(B_qx11) < 14 ){
  B_qx11 <- B_qx0}

B_qx12 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2596:X2596")  
B_qx12 <- B_qx12 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "484__33025 - QUIRÓFANOS TORACICA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx12$...1 + B_qx12$...10, .after = 13) #Mama
if(length(B_qx12) < 14 ){
  B_qx12 <- B_qx0}

B_qx13 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2639:X2639")  
B_qx13 <- B_qx13 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "486__33027 - QUIRÓFANOS UROLOGÍA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx13$...1 + B_qx13$...10, .after = 13) #Gine
if(length(B_qx13) < 14 ){
  B_qx13 <- B_qx0}

B_qx14 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2654:X2654")  
B_qx14 <- B_qx14 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "484__33025 - QUIRÓFANOS TORACICA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx14$...1 + B_qx14$...10, .after = 13) #Obs
if(length(B_qx14) < 14 ){
  B_qx14 <- B_qx0}


B_qx15 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2888:X2888")  
B_qx15 <- B_qx15 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "485__33026 - QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx15$...1 + B_qx15$...10, .after = 13)
if(length(B_qx15) < 14 ){
  B_qx15 <- B_qx0}


B_qx16 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2893:X2893")  
B_qx16 <- B_qx16 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "485__33026 - QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx16$...1 + B_qx16$...10, .after = 13)
if(length(B_qx16) < 14 ){
  B_qx16 <- B_qx0}

B_qxCMA <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                     range = "B!O2893:X2893")  #lee cualquier rango solo para darle la forma
B_qxCMA <- B_qxCMA %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "471__33012 - QUIRÓFANOS MAYOR AMBULATORIA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx1$...4 + B_qx2$...4 + B_qx3$...4 + B_qx4$...4 + B_qx5$...4 + B_qx6$...4 +
               B_qx7$...4 + B_qx8$...4 + B_qx9$...4 + B_qx10$...4 + B_qx11$...4 + B_qx12$...4 + 
               B_qx13$...4 + B_qx14$...4 + B_qx15$...4 + B_qx16$...4, .after = 13)

B_qx <- rbind(B_qx1,B_qx2,B_qx3,B_qx4,B_qx5,B_qx6,B_qx7,B_qx8,B_qx9, B_qx10,
              B_qx11,B_qx12,B_qx13,B_qx14,B_qx15,B_qx16,B_qxCMA)

B_qx <- B_qx %>% filter(`Centro de Producción` !=0)

rm(B_qx1,B_qx2,B_qx3,B_qx4,B_qx5,B_qx6,B_qx7,B_qx8,B_qx9, B_qx10,
   B_qx11,B_qx12,B_qx13,B_qx14,B_qx15,B_qx16, B_qxCMA, B_qx0)

B_qx <- B_qx %>% group_by(Fecha, `Centro de Producción`, `Unidades de Producción`) %>% 
  summarise("Valor" = sum(Valor))

B_qx <- B_qx %>% group_by(Fecha, `Centro de Producción`, `Unidades de Producción`) %>% 
  summarise("Valor" = sum(Valor))

B_qx$Fecha <- NULL

#Crea una proporcion donde 2CMA=CNA
B_qx$prop_CMA_vs_CNA <- prop.table(ifelse(B_qx$`Centro de Producción`!= "471__33012 - QUIRÓFANOS MAYOR AMBULATORIA", B_qx$Valor*propocion_CMA,B_qx$Valor))
prop_CMA <- sum(ifelse(B_qx$`Centro de Producción`== "471__33012 - QUIRÓFANOS MAYOR AMBULATORIA", B_qx$prop_CMA_vs_CNA,0))

# Leer Oferta de Pabellones -----------------------------------------------

leer_pdf <- pdf_text(ruta_pdf) %>% 
  str_remove_all("       HOSPITAL DE NIÑOS ROBERTO DEL RÍO") %>% 
  str_remove_all("       Unidad de anestesia y pabellón") %>%
  str_split("\n")

ocupacion <- data.frame(especialidad = c(), horas_ocupadas = c())
oferta <- c("BRONCOPULMONAR", "CARDIOLOGIA", "CIRUGIA GENERAL", "COLUMNA", "DENTAL", "DERMATOLOGIA", "ELECTROFISIOLOGÍA", "ESPECIAL ",
            "FLEXIBLE", "GASTROENTEROLOGIA", "GINECOLOGIA", "HEMODINAMIA", "MAXILOFACIAL", "NEFROLOGÍA", "NEUROCIRUGIA", "OFTALMOLOGIA",
            "ONCOLOGIA", "OTORRINOLARINGOLOGIA", "PLASTICA", "QUEMADOS", "TRAUMATOLOGIA Y ORTOPEDIA", "URGENCIA", "UROLOGIA")

for (i in oferta) {
a <- str_count(leer_pdf, i)   #me busca en la hoja del pdf
b <- str_count(leer_pdf[[which.max(a)]], i) #me busca en el texto de esa hoja
c <- leer_pdf[[which.max(a)]][which.max(b)] #es la coordenada de la linea que coincide
d <- strsplit(c," ")
e <- as.data.frame.list(d)
colnames(e)[1] <- "dato"
e <- e %>% filter(dato != "")
f <- ifelse(i == "TRAUMATOLOGIA Y ORTOPEDIA", as.numeric(e$dato[5]), as.numeric(e$dato[3]))

x <- data.frame(especialidad = i, horas_ocupadas = f)

ocupacion <- rbind(ocupacion,x)
rm(a,b,c,d,e,f,x)
}

ocupacion <- ocupacion %>% mutate(
  SIGCOM = case_when(
    especialidad == "BRONCOPULMONAR" ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "CARDIOLOGIA" ~ "464-QUIRÓFANOS CARDIOVASCULAR",
    especialidad == "CIRUGIA GENERAL" ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "COLUMNA" ~ "475-QUIRÓFANOS NEUROCIRUGÍA", #preguntar
    especialidad == "DENTAL" ~ "462-QUIRÓFANOS CABEZA Y CUELLO",
    especialidad == "DERMATOLOGIA" ~ "486-QUIRÓFANOS UROLOGÍA",
    especialidad == "ELECTROFISIOLOGÍA" ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "ESPECIAL " ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "FLEXIBLE" ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "GASTROENTEROLOGIA" ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "GINECOLOGIA" ~ "486-QUIRÓFANOS UROLOGÍA",
    especialidad == "HEMODINAMIA" ~ "464-QUIRÓFANOS CARDIOVASCULAR",
    especialidad == "MAXILOFACIAL" ~ "462-QUIRÓFANOS CABEZA Y CUELLO",
    especialidad == "NEFROLOGÍA" ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "NEUROCIRUGIA" ~ "475-QUIRÓFANOS NEUROCIRUGÍA",
    especialidad == "OFTALMOLOGIA" ~ "462-QUIRÓFANOS CABEZA Y CUELLO",
    especialidad == "ONCOLOGIA" ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "OTORRINOLARINGOLOGIA" ~ "462-QUIRÓFANOS CABEZA Y CUELLO",
    especialidad == "PLASTICA" ~ "493-QUIRÓFANOS CIRUGÍA PLÁSTICA",
    especialidad == "QUEMADOS" ~ "493-QUIRÓFANOS CIRUGÍA PLÁSTICA",
    especialidad == "TRAUMATOLOGIA Y ORTOPEDIA" ~ "485-QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA",
    especialidad == "URGENCIA" ~ "Pabellon Urgencia",
    especialidad == "UROLOGIA" ~ "486-QUIRÓFANOS UROLOGÍA",
    TRUE ~ "Asignar Centro de Costo")) %>% filter(horas_ocupadas > 0)

ocupacion$prop_total <- ocupacion$horas_ocupadas/sum(ocupacion$horas_ocupadas)
u <- sum(ifelse(ocupacion$especialidad == "URGENCIA", ocupacion$horas_ocupadas, 0))
ocupacion_pabellones <- ocupacion %>% filter(especialidad != "URGENCIA")
horas_CMA <- sum(prop_CMA*ocupacion_pabellones$horas_ocupadas)
ocupacion_pabellones$horas_ocupadas <- (1-prop_CMA)*ocupacion_pabellones$horas_ocupadas


ocupacion_pabellones$horas_ocupadas <- ifelse(ocupacion_pabellones$especialidad == "TRAUMATOLOGIA Y ORTOPEDIA",
                               ocupacion_pabellones$horas_ocupadas + u*prop_urg,ocupacion_pabellones$horas_ocupadas)
ocupacion_pabellones$horas_ocupadas <- ifelse(ocupacion_pabellones$especialidad == "CIRUGIA GENERAL",
                               ocupacion_pabellones$horas_ocupadas + u*(1-prop_urg), ocupacion_pabellones$horas_ocupadas)

CMA <- data.frame(especialidad = "CMA", horas_ocupadas = horas_CMA, SIGCOM = "471-QUIRÓFANOS MAYOR AMBULATORIA", prop_total = prop_CMA)
ocupacion_pabellones <- rbind(ocupacion_pabellones, CMA)

ocupacion_pabellones$prop_total <- prop.table(ocupacion_pabellones$horas_ocupadas)

ocupacion_pabellones <- ocupacion_pabellones %>% select(SIGCOM, prop_total) %>% 
  group_by(SIGCOM) %>% 
  summarise(prop_total=sum(prop_total)) %>% 
  ungroup() 

ocupacion_CME <- ocupacion_pabellones %>% filter(SIGCOM == "471-QUIRÓFANOS MAYOR AMBULATORIA")
ocupacion_CME$prop_total <- ocupacion_CME$prop_total*(1-prop_CME_a_CMA)
CME <- data.frame(SIGCOM = "473-QUIRÓFANOS MENOR AMBULATORIA", prop_total = ocupacion_CME$prop_total*(prop_CME_a_CMA))

ocupacion_CME <- rbind(ocupacion_CME, CME)
ocupacion_pabellones <- ocupacion_pabellones %>% 
  filter(SIGCOM != "471-QUIRÓFANOS MAYOR AMBULATORIA")

ocupacion_pabellones <- rbind(ocupacion_pabellones, ocupacion_CME)
  


ocupacion_pabellones$prop_total <-  prop.table(ocupacion_pabellones$prop_total)

openxlsx::write.xlsx(ocupacion_pabellones, graba, colNames = TRUE, sheetName = "pabellon", overwrite = TRUE)