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
mes <- "12"
propocion_CMA <- 2 #proporcion de 2CMA = 1CNA
prop_urg <- 0.5 #proporcion con 50% de la urgencia a TMT y 50% a cirugia
mes_completo <- c("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre")
mes_completo <- mes_completo[as.numeric(mes)]
Fecha_filtro <- paste0(anio,"-",mes,"-01")
archivoBS <-paste0("C:/Users/control.gestion3/OneDrive/BBDD Produccion/REM/Serie BS/",anio,"/",anio,"-",mes," REM serie BS.xlsx")
graba <-paste0("C:/Users/control.gestion3/OneDrive/BBDD Produccion/PERC/PERC ",anio,"/",mes," ",mes_completo,"/Insumos de Informacion/89_Pabellon.xlsx")

# Producción Pabellones ---------------------------------------------------


B_qx1 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1380:X1380") 
B_qx1 <- B_qx1 %>%   add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "475__33016 - QUIRÓFANOS NEUROCIRUGÍA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx1$...1 + B_qx1$...10, .after = 13) 


B_qx2 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1514:X1514") 
B_qx2 <- B_qx2 %>%   add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx2$...1 + B_qx2$...10, .after = 13) 

B_qx3 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1696:X1696")  
B_qx3 <- B_qx3 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx3$...1 + B_qx3$...10, .after = 13)

B_qx4 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1760:X1760")  
B_qx4 <- B_qx4 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx4$...1 + B_qx4$...10, .after = 13) 

B_qx5 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1834:X1834")  
B_qx5 <- B_qx5 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "493__33034 - QUIRÓFANOS CIRUGÍA PLÁSTICA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx5$...1 + B_qx5$...10, .after = 13) 

B_qx6 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O1877:X1877")  
B_qx6 <- B_qx6 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx6$...1 + B_qx6$...10, .after = 13) 

B_qx7 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O2104:X2104")  
B_qx7 <- B_qx7 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "464__33005 - QUIRÓFANOS CARDIOVASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx7$...1 + B_qx7$...10, .after = 13)

B_qx8 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O2190:X2190")  
B_qx8 <- B_qx8 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx8$...1 + B_qx8$...10, .after = 13)

B_qx9 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                   range = "B!O2379:X2379")  
B_qx9 <- B_qx9 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "467__33008 - QUIRÓFANOS DIGESTIVA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx9$...1 + B_qx9$...10, .after = 13)

B_qx10 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2419:X2419")  
B_qx10 <- B_qx10 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx10$...1 + B_qx10$...10, .after = 13)

B_qx11 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2541:X2541")  
B_qx11 <- B_qx11 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "486__33027 - QUIRÓFANOS UROLOGÍA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx11$...1 + B_qx11$...10, .after = 13)

B_qx12 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2575:X2575")  
B_qx12 <- B_qx12 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx12$...1 + B_qx12$...10, .after = 13)

B_qx13 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2615:X2615")  
B_qx13 <- B_qx13 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx13$...1 + B_qx13$...10, .after = 13)

B_qx14 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2631:X2631")  
B_qx14 <- B_qx14 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "495__33036 - QUIRÓFANOS CIRUGÍA VASCULAR", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx14$...1 + B_qx14$...10, .after = 13)

B_qx15 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2865:X2865")  
B_qx15 <- B_qx15 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "485__33026 - QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx15$...1 + B_qx15$...10, .after = 13)

B_qx16 <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                    range = "B!O2870:X2870")  
B_qx16 <- B_qx16 %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "485__33026 - QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx16$...1 + B_qx16$...10, .after = 13)

B_qxCMA <- read_xlsx(archivoBS, na = " ",col_names = FALSE,
                     range = "B!O2870:X2870")  #lee cualquier rango solo para darle la forma
B_qxCMA <- B_qxCMA %>%  add_column("Fecha" = Fecha_filtro, .after = 10) %>% 
  add_column("Centro de Producción" = "471__33012 - QUIRÓFANOS MAYOR AMBULATORIA", .after = 11) %>% 
  add_column("Unidades de Producción" = "1__Intervencion quirurgica", .after = 12) %>% 
  add_column("Valor" = B_qx1$...4 + B_qx2$...4 + B_qx3$...4 + B_qx4$...4 + B_qx5$...4 + B_qx6$...4 +
               B_qx7$...4 + B_qx8$...4 + B_qx9$...4 + B_qx10$...4 + B_qx11$...4 + B_qx12$...4 + 
               B_qx13$...4 + B_qx14$...4 + B_qx15$...4 + B_qx16$...4, .after = 13)

B_qx <- rbind(B_qx1,B_qx2,B_qx3,B_qx4,B_qx5,B_qx6,B_qx7,B_qx8,B_qx9, B_qx10,
              B_qx11,B_qx12,B_qx13,B_qx14,B_qx15,B_qx16,B_qxCMA)

rm(B_qx1,B_qx2,B_qx3,B_qx4,B_qx5,B_qx6,B_qx7,B_qx8,B_qx9, B_qx10,
   B_qx11,B_qx12,B_qx13,B_qx14,B_qx15,B_qx16, B_qxCMA)

B_qx <- B_qx %>% group_by(Fecha, `Centro de Producción`, `Unidades de Producción`) %>% 
  summarise("Valor" = sum(Valor))

#Crea una proporcion donde 2CMA=CNA
B_qx$prop_CMA_vs_CNA <- prop.table(ifelse(B_qx$`Centro de Producción`!= "471__33012 - QUIRÓFANOS MAYOR AMBULATORIA", B_qx$Valor*propocion_CMA,B_qx$Valor))
prop_CMA <- sum(ifelse(B_qx$`Centro de Producción`== "471__33012 - QUIRÓFANOS MAYOR AMBULATORIA", B_qx$prop_CMA_vs_CNA,0))

# Leer Oferta de Pabellones -----------------------------------------------

leer_pdf <- pdf_text("C:/Users/control.gestion3/OneDrive/BBDD Produccion/PERC/PERC 2023/12 Diciembre/Insumos de Informacion/88_Oferta_Pabellones.pdf") %>% 
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
    especialidad == "DENTAL" ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "DERMATOLOGIA" ~ "486-QUIRÓFANOS UROLOGÍA",
    especialidad == "ELECTROFISIOLOGÍA" ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "ESPECIAL " ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "FLEXIBLE" ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "GASTROENTEROLOGIA" ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "GINECOLOGIA" ~ "486-QUIRÓFANOS UROLOGÍA",
    especialidad == "HEMODINAMIA" ~ "464-QUIRÓFANOS CARDIOVASCULAR",
    especialidad == "MAXILOFACIAL" ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "NEFROLOGÍA" ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "NEUROCIRUGIA" ~ "475-QUIRÓFANOS NEUROCIRUGÍA",
    especialidad == "OFTALMOLOGIA" ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "ONCOLOGIA" ~ "484-QUIRÓFANOS TORACICA",
    especialidad == "OTORRINOLARINGOLOGIA" ~ "484-QUIRÓFANOS TORACICA",
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

ocupacion_pabellones <- ocupacion_pabellones %>% filter(SIGCOM != "464-QUIRÓFANOS CARDIOVASCULAR")  
ocupacion_pabellones$prop_total <-  prop.table(ocupacion_pabellones$prop_total)

openxlsx::write.xlsx(ocupacion_pabellones, graba, colNames = TRUE, sheetName = "pabellon", overwrite = TRUE)