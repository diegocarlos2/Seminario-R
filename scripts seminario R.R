#Crear un vector
# Vector numérico
c(1, 2, 3, 5, 8, 13)

# Vector de cadena de texto
c("arbol", "casa", "persona")

a<- seq(1,100, by=5)
#para subsetear un vector usamos []
a[3]
a[-3]
a[c(2,10,15)]

# Un vector numérico del uno al doce
1:12

# matrix() sin especificar renglones ni columnas
matrix(1:12)

# Tres renglones y cuatro columnas
matrix(1:12, nrow = 3, ncol = 4)

# Cuatro columnas y tres columnas
matrix(1:12, nrow = 4, ncol = 3)

# Dos renglones y seis columnas
matrix(1:12, nrow = 4, ncol = 3)
# subsetear una matriz [r,c]

#Crear un data frame
mi_df <- data.frame("entero" = 1:4, "factor" = c("a", "b", "c", "d"),
                    "numero" = c(1.2, 3.4, 4.5, 5.6),
                    "cadena" = as.character(c("a", "b", "c", "d")))

mi_df

# Podemos usar dim() en un data frame
dim(mi_df)

# El largo de un data frame es igual a su número de columnas
length(mi_df)

# names() nos permite ver los nombres de las columnas
names(mi_df)

# La clase de un data frame es data.frame
class(mi_df) 
str(mi_df)


#Descarga de datos
download.file(url = "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data", destfile = "iris.data")
getwd()
setwd("C:/Users/Usuario/Desktop/seminario R")

# Tablas (datos rectangulares)
read.table("C:/Users/Usuario/Desktop/seminario R/iris.data")
iris<-read.table("C:/Users/Usuario/Desktop/seminario R/iris.data",header=TRUE, sep=",")
#View(iris)
iris<-read.table("C:/Users/Usuario/Desktop/seminario R/iris.data", header=FALSE, sep=",")
#View(iris)
#podemos ver los primeros renglones nuestros datos usando la función `head()` 
head(iris)
#como no tienen nombres podemos asignarlos creando un vector
nombres<- c("largo Sépalo", "ancho Sépalo", "largo Pétalo", "ancho Pétalo", "Variedad")

class(iris)

#Archivos CSV
download.file(url = "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data", destfile = "iris.data2.csv")
#podemos usar read.table
iris<-read.table("iris.data2.csv", header=FALSE, sep=",", col.names=nombres)

iris <- read.csv("iris.data2.csv")
#le agregamos el vector con los nombres
iris <- read.csv("iris.data2.csv", header=FALSE, col.names=nombres)
View(iris)

#Archivos con una estructura desconocida
file.show("iris.data2.csv")

# Exportar datos

data(iris)
write.table(x = iris, file = "iris.txt", sep = ",", row.names = FALSE, col.names = TRUE)

#tambien podemos guardarlo como .csv o .xls 
write.table(x = iris, file = "iris.csv", sep = ",", row.names = FALSE, col.names = TRUE)

#Ahora probemos cargarlo nuevamente pero usando el comando file->import Dataset

# Medidas descriptivas

data(iris)
str(iris)
summary(iris)
summary(iris$Sepal.Length)
attach(iris)

#usamos el comando tapply para analizar algunos descriptivos por especie
tapply(Petal.Length,Species,summary)
tapply(Petal.Width,Species,summary)
tapply(Sepal.Length,Species,summary)
tapply(Sepal.Width,Species,summary)

#tambien se puede usar la funcion by
by(iris, iris$Species, summary)

# Gráficos
# Histogramas
hist(x = Petal.Length)

#podemos configurar las distintas partes del gráfico
hist(x = Petal.Length, main = "Histograma largo del Pétalo", 
     xlab = "Largo (cm)", ylab = "Frecuencia",col="red")

# Gráficas de barras
plot(Species)
plot(Species, main= "Distribución por especies", 
     xlab="frec Abs", col= c("blue", "red","green"))

# Diagramas de dispersión
plot(x = Petal.Length, y = Petal.Width, col=Species)


# más completo
plot(x = iris$Petal.Length, y = iris$Petal.Width, col = iris$Species, 
     main = "Iris - Pétalo", xlab = "Largo", ylab = "Ancho")
legend(x = "topleft", legend = c("Setosa", "Versicolor", "Virginica"), 
       fill = c("black", "red", "green"), title = "Especie")

# Diagramas de caja
plot(x = Species, y = Petal.Length)
plot(x = Species, y = Petal.Length, main = "Largo del Pétalo", 
     xlab = "Especie", ylab = "Largo (cm)", 
     col = c("orange3", "yellow3", "green3"))

boxplot(x = Sepal.Length)

boxplot(formula = Sepal.Length ~ Species, data =  iris)

# Tidyverse

install.packages(tidyverse)
library(tidyverse)

# dplyr
# Summarise para resumir
Resumen_Largo_Petalo <- summarise(iris, Media_Largo_Petalo = mean(Petal.Length), 
                                  Mediana_Largo_Petalo = median(Petal.Length),
                                  Desviacion_Largo_Petalo = sd(Petal.Length))

# Group_by y Summarise

Resumen_Largo_Petalo <- group_by(iris, Species)

Resumen_Largo_Petalo <- summarise(Resumen_Largo_Petalo, Media_Largo_Petalo = mean(Petal.Length), 
                                  Mediana_Largo_Petalo = median(Petal.Length),
                                  Desviacion_Largo_Petalo = sd(Petal.Length))

write.csv(Resumen_Largo_Petalo, "Resumen.csv")

# Mutate: para crear nuevas variables
DF <- mutate(iris, RazonPetaloSepalo = Sepal.Length/Petal.Length)

DF <- group_by(DF, Species)

DF <- summarise(DF, RazonPetaloSepalo = mean(RazonPetaloSepalo), N = n())

# Pipeline %>%  --- Crear un pipeline en Rstudio: ctr +  shift + m ---

x <- c(1, 4, 6, 8)
y <- round(mean(sqrt(log(x))), 2)

y <- x %>% log %>% sqrt %>% mean %>% round(4)

DF <- iris %>% mutate(RazonPetaloSepalo = Sepal.Length/Petal.Length) %>% 
  group_by(Species) %>% summarise(RazonPetaloSepalo = mean(RazonPetaloSepalo), N = n())




