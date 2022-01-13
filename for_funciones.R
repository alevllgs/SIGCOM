library(tidyverse)
library(readxl)
library(lubridate)
library(janitor)
library(dplyr)
library(openxlsx)
library(xlsx)


# Ejemplo FOR -------------------------------------------------------------


cuentas <- c("48-SERVICIO DE AGUA",
             "182-SERVICIO DE VIGILANCIA Y SEGURIDAD",
             "46-VÍVERES",
             "43-PRODUCTOS TEXTILES, VESTUARIO Y CALZADO",
             "24-MATERIALES DE OFICINA, PRODUCTOS DE PAPEL E IMPRESOS",
             "9-GASES MEDICINALES",
             "41-PRODUCTOS QUÍMICOS")


GG1 <- data.frame(
  "Centro de Costo" = c("eliminar"), 
  "Devengado" = 0, 
  "Cuenta" = c("eliminar"),
  "Tipo" = 1)
colnames(GG1)[1] <- "Centro de Costo"


for (i in cuentas) {
  if(i %in% SIGFE$SIGCOM) {
    GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
      summarise(Devengado = sum(Devengado)) %>% 
      filter(SIGCOM == i)
    GG2 <- GG2 %>% summarise("Centro de Costo" = M2$CC, 
                             Devengado = Devengado*M2$prop, 
                             "Cuenta"=i, "Tipo" = 1)
    GG1 <- rbind(GG1,GG2) }
    else {GG2 <- data.frame(
      "Centro de Costo" = c("eliminar"), 
      "Devengado" = 0, 
      "Cuenta" = c("eliminar"),
      "Tipo" = 1)
    colnames(GG2)[1] <- "Centro de Costo"
    GG1 <- rbind(GG1,GG2)}
                             }

GG22 <- GG2
GG11 <- GG1

# FORMULAS ----------------------------------------------------------------



cuentas <- c("48-SERVICIO DE AGUA",
             "182-SERVICIO DE VIGILANCIA Y SEGURIDAD",
             "46-VÍVERES",
             "43-PRODUCTOS TEXTILES, VESTUARIO Y CALZADO",
             "24-MATERIALES DE OFICINA, PRODUCTOS DE PAPEL E IMPRESOS",
             "9-GASES MEDICINALES",
             "41-PRODUCTOS QUÍMICOS")


GG1 <- data.frame(
  "Centro de Costo" = c("eliminar"), 
  "Devengado" = 0, 
  "Cuenta" = c("eliminar"),
  "Tipo" = 1)
colnames(GG1)[1] <- "Centro de Costo"


funcion_consumoxCC <- function(SIGFE, GG1) {
  for (i in cuentas) {
    if(i %in% SIGFE$SIGCOM) {
      GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
        summarise(Devengado = sum(Devengado)) %>% 
        filter(SIGCOM == i)
      GG2 <- GG2 %>% summarise("Centro de Costo" = M2$CC, 
                               Devengado = Devengado*M2$prop, 
                               "Cuenta"=i, "Tipo" = 1)
      GG1 <- rbind(GG1,GG2) }
    else {GG2 <- data.frame(
      "Centro de Costo" = c("eliminar"), 
      "Devengado" = 0, 
      "Cuenta" = c("eliminar"),
      "Tipo" = 1)
    colnames(GG2)[1] <- "Centro de Costo"
    GG1 <- rbind(GG1,GG2)}
  }
}

# funcion_sinconsumoxCC <- function(GG1)  {
#   GG2 <- data.frame(
#   "Centro de Costo" = c("eliminar"), 
#   "Devengado" = 0, 
#   "Cuenta" = c("eliminar"),
#   "Tipo" = 1)
# colnames(GG2)[1] <- "Centro de Costo"
# GG1 <- rbind(GG1,GG2)}
# 
for (i in cuentas) {
  if(i %in% SIGFE$SIGCOM) {funcion_consumoxCC
    }
  else {funcion_sinconsumoxCC}
}





for (i in cuentas) {
  if(i %in% SIGFE$SIGCOM) {
    GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
      summarise(Devengado = sum(Devengado)) %>% 
      filter(SIGCOM == i)
    GG2 <- GG2 %>% summarise("Centro de Costo" = M2$CC, 
                             Devengado = Devengado*M2$prop, 
                             "Cuenta"=i, "Tipo" = 1)
    GG1 <- rbind(GG1,GG2) }
  else {GG2 <- data.frame(
    "Centro de Costo" = c("eliminar"), 
    "Devengado" = 0, 
    "Cuenta" = c("eliminar"),
    "Tipo" = 1)
  colnames(GG2)[1] <- "Centro de Costo"
  GG1 <- rbind(GG1,GG2)}
}






















funcion_consumoxCC <- function(i, SIGFE) {
  GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
  summarise(Devengado = sum(Devengado)) %>% 
  filter(SIGCOM == i)
GG2 <- GG2 %>% summarise("Centro de Costo" = M2$CC, 
                         Devengado = Devengado*M2$prop, 
                         "Cuenta"=i, "Tipo" = 1)
GG1 <- rbind(GG1,GG2) }
  
funcion_sinconsumoxCC <- function(i, SIGFE)  
  {GG2 <- data.frame(
  "Centro de Costo" = c("eliminar"), 
  "Devengado" = 0, 
  "Cuenta" = c("eliminar"),
  "Tipo" = 1)
colnames(GG2)[1] <- "Centro de Costo"
GG1 <- rbind(GG1,GG2)}
  
  


a <- "48-SERVICIO DE AGUA"
if(a %in% SIGFE$SIGCOM){
  GG1 <-  SIGFE %>% group_by(SIGCOM) %>% 
    summarise(Devengado = sum(Devengado)) %>% 
    filter(SIGCOM == a)
  GG1 <- GG1 %>% summarise("Centro de Costo" = M2$CC, 
                           Devengado = Devengado*M2$prop, 
                           "Cuenta"=a, "Tipo" = 1)} else {GG1 <-  data.frame(
                             "Centro de Costo" = c("eliminar"), 
                             "Devengado" = 0, 
                             "Cuenta" = c("eliminar"),
                             "Tipo" = 1)
                           colnames(GG1)[1] <- "Centro de Costo"
                           }

b <- "182-SERVICIO DE VIGILANCIA Y SEGURIDAD"
if(b %in% SIGFE$SIGCOM){
  GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
    summarise(Devengado = sum(Devengado)) %>% 
    filter(SIGCOM == b)
  GG2 <- GG2 %>% summarise("Centro de Costo" = M2$CC, 
                           Devengado = Devengado*M2$prop, 
                           "Cuenta"=b, "Tipo" = 1)
  GG1 <- rbind(GG1,GG2)}

b <- "170-SERVICIO DE ASEO"
if(b %in% SIGFE$SIGCOM){
  GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
    summarise(Devengado = sum(Devengado)) %>% 
    filter(SIGCOM == b)
  GG2 <- GG2 %>% summarise("Centro de Costo" = M2$CC, 
                           Devengado = Devengado*M2$prop, 
                           "Cuenta"=b, "Tipo" = 1)
  GG1 <- rbind(GG1,GG2)}

b <- "92-SERVICIO DE ENERGÍA"
if(b %in% SIGFE$SIGCOM){
  GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
    summarise(Devengado = sum(Devengado)) %>% 
    filter(SIGCOM == b)
  GG2 <- GG2 %>% summarise("Centro de Costo" = M2$CC, 
                           Devengado = Devengado*M2$prop, 
                           "Cuenta"=b, "Tipo" = 1)
  GG1 <- rbind(GG1,GG2)}

b <- "179-SERVICIO DE MENSAJERIA Y/O CORREO"
if(b %in% SIGFE$SIGCOM){
  GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
    summarise(Devengado = sum(Devengado)) %>% 
    filter(SIGCOM == b)
  GG2 <- GG2 %>% summarise("Centro de Costo" = M2$CC, 
                           Devengado = Devengado*M2$prop, 
                           "Cuenta"=b, "Tipo" = 1)
  GG1 <- rbind(GG1,GG2)}

b <- "100-GAS PROPANO"
if(b %in% SIGFE$SIGCOM){
  GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
    summarise(Devengado = sum(Devengado)) %>% 
    filter(SIGCOM == b)
  GG2 <- GG2 %>% summarise("Centro de Costo" = M2$CC, 
                           Devengado = Devengado*M2$prop, 
                           "Cuenta"=b, "Tipo" = 1)
  GG1 <- rbind(GG1,GG2)}

b <- "133-MANTENIMIENTO PLANTA FÍSICA"
if(b %in% SIGFE$SIGCOM){
  GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
    summarise(Devengado = sum(Devengado)) %>% 
    filter(SIGCOM == b)
  GG2 <- GG2 %>% summarise("Centro de Costo" = M2$CC, 
                           Devengado = Devengado*M2$prop, 
                           "Cuenta"=b, "Tipo" = 1)
  GG1 <- rbind(GG1,GG2)}


b <- "158-PUBLICIDAD Y PROPAGANDA"
if(b %in% SIGFE$SIGCOM){
  GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
    summarise(Devengado = sum(Devengado)) %>% 
    filter(SIGCOM == b)
  GG2 <- GG2 %>% summarise("Centro de Costo" = M2$CC, 
                           Devengado = Devengado*M2$prop, 
                           "Cuenta"=b, "Tipo" = 1)
  GG1 <- rbind(GG1,GG2)
}

b <- "93-ENLACES DE TELECOMUNICACIONES"
if(b %in% SIGFE$SIGCOM)
{GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
  summarise(Devengado = sum(Devengado)) %>% 
  filter(SIGCOM == b)
GG2 <- GG2 %>% summarise("Centro de Costo" = M2$CC, 
                         Devengado = Devengado*M2$prop, 
                         "Cuenta"=b, "Tipo" = 1)
GG1 <- rbind(GG1,GG2)}

b <- "188-SERVICIOS GENERALES"
if(b %in% SIGFE$SIGCOM)
{GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
  summarise(Devengado = sum(Devengado)) %>% 
  filter(SIGCOM == b)
GG2 <- GG2 %>% summarise("Centro de Costo" = M2$CC, 
                         Devengado = Devengado*M2$prop, 
                         "Cuenta"=b, "Tipo" = 1)
GG1 <- rbind(GG1,GG2)}

b <- "192-SERVICIO DE TELECOMUNICACIONES"
if(b %in% SIGFE$SIGCOM)
{GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
  summarise(Devengado = sum(Devengado)) %>% 
  filter(SIGCOM == b)
GG2 <- GG2 %>% summarise("Centro de Costo" = M2$CC, 
                         Devengado = Devengado*M2$prop, 
                         "Cuenta"=b, "Tipo" = 1)
GG1 <- rbind(GG1,GG2)}

b <- "128-MANTENIMIENTO DE PRADOS Y JARDINES"
if(b %in% SIGFE$SIGCOM)
{GG2 <-  SIGFE %>% group_by(SIGCOM) %>% 
  summarise(Devengado = sum(Devengado)) %>% 
  filter(SIGCOM == b)
GG2 <- GG2 %>% summarise("Centro de Costo" = M2$CC, 
                         Devengado = Devengado*M2$prop, 
                         "Cuenta"=b, "Tipo" = 1)
GG1 <- rbind(GG1,GG2)}