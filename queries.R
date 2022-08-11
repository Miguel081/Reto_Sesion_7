# Reto_Sesion_7

install.packages("DBI")
install.packages("RMySQL")
install.packages("dplyr")
install.packages("plotly")


library(DBI)
library(RMySQL)
library(dplyr)
library(plotly)


MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)


db_cl2 <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
db_cl <- dbGetQuery(MyDataBase, "select * from CountryLanguage where Language =	'Spanish' ")
str(db_cl)

####
p <- ggplot(db_cl, aes(x=Percentage ,y=CountryCode)) + 
  geom_bin2d() +  
  labs(title = "Distribution of Canadian areas by English and French fluency",
       x = "% fluent in English",
       y = "% fluent in French",
       fill = "# of census \nsubdivisions")
fig <- ggplotly(p)

fig
####

ggplot(db_cl, aes(x= Percentage, y=CountryCode, fill=CountryCode)) + 
  geom_bar(stat = "identity") 