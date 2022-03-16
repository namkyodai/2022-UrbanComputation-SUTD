#Loading necessary packages
library(tidyverse)
library(lubridate)  # date functions
library(scales)     # extending {ggplot2}
library(glue)       # for gluing strings together
#
# utilities
library(cansim)     # data extract
library(janitor)    # for `clean_names()`
library(knitr)      # for publication - includes `kable()` for tables
library(kableExtra) # - format kable tables
library(flextable)  # another table formatting package
#load in function

source("f_monthyear.R")
source("bida_chart_theme.R")
# WE START HERE

source("import.R")
source("cleaning.R")
source("filtering.R")
source("table_visualize.R")
source("table_communicate.R")
source("text.R")
source("visualize.R")










#text







