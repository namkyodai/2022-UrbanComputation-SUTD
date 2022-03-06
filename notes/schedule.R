library(DT)
library(tidyverse)
library(readxl) 
library(lubridate)
df=read_excel("program.xlsx",sheet="program",skip = 0)
df$Date <- as.Date(df$Date,format = "%d/%m/%y")
p <- datatable(df,rownames = FALSE, filter = 'top',
          options = list(pageLength = 10,
            columnDefs = list(list(className = 'dt-left', targets = c(1,2,4)),list(className = 'dt-center', targets = c(0,3,5)))
            ,autoWidth = TRUE)
          )




