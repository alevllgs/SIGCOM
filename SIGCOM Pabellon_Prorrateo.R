library(tidyverse)
library(stringr)
library(pdftools)

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
    especialidad == "BRONCOPULMONAR" ~ "",
    especialidad == "CARDIOLOGIA" ~ "464-QUIRÓFANOS CARDIOVASCULAR",
    especialidad == "CIRUGIA GENERAL" ~ "",
    especialidad == "COLUMNA" ~ "",
    especialidad == "DENTAL" ~ "",
    especialidad == "DERMATOLOGIA" ~ "",
    especialidad == "ELECTROFISIOLOGÍA" ~ "",
    especialidad == "ESPECIAL " ~ "",
    especialidad == "FLEXIBLE" ~ "",
    especialidad == "GASTROENTEROLOGIA" ~ "",
    especialidad == "GINECOLOGIA" ~ "",
    especialidad == "HEMODINAMIA" ~ "464-QUIRÓFANOS CARDIOVASCULAR",
    especialidad == "MAXILOFACIAL" ~ "",
    especialidad == "NEFROLOGÍA" ~ "",
    especialidad == "NEUROCIRUGIA" ~ "475-QUIRÓFANOS NEUROCIRUGÍA",
    especialidad == "OFTALMOLOGIA" ~ "471-QUIRÓFANOS MAYOR AMBULATORIA",
    especialidad == "ONCOLOGIA" ~ "",
    especialidad == "OTORRINOLARINGOLOGIA" ~ "471-QUIRÓFANOS MAYOR AMBULATORIA",
    especialidad == "PLASTICA" ~ "493-QUIRÓFANOS CIRUGÍA PLÁSTICA",
    especialidad == "QUEMADOS" ~ "493-QUIRÓFANOS CIRUGÍA PLÁSTICA",
    especialidad == "TRAUMATOLOGIA Y ORTOPEDIA" ~ "485-QUIRÓFANOS TRAUMATOLOGÍA Y ORTOPEDIA",
    especialidad == "URGENCIA" ~ "",
    especialidad == "UROLOGIA" ~ "486-QUIRÓFANOS UROLOGÍA",
    TRUE ~ "Asignar Centro de Costo"))
