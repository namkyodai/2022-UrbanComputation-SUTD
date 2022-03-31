Hallo All,


Week 3 assignment will be on data wrangling/maniuplation with [dplyr library](https://dplyr.tidyverse.org/index.html) and visualization with [ggplot2 library](https://ggplot2.tidyverse.org/).

Thru doing the assignment, you will gain basic knowledge on the several key syntax (function) from dplyr library, the concept of pipeline, and the concept of having different layers in visualization.

Some good reading materials are

- [Introduction to dplyr](https://dplyr.tidyverse.org/articles/dplyr.html)
- [ggplot2 Elegant Graphics for Data Analysis](https://ggplot2-book.org/)

Other than ggplot2 package, you can read the followig book on [R graphic](https://r-graphics.org/), there is a section on ggplot2.


# Requirements for both two groups

## Group 1
- Dataset for group 1 is time series data on weather in Singapore. I have downloaded a number of csv files for Changi station and save them under **[sg-weather folder](https://github.com/namkyodai/2022-UrbanComputation-SUTD/tree/main/notes/sg-weather)**. Your job is to merge these files into a single csv file, then use dplyr and ggplot2 library to come up with some meaningful tables and graphs.

- For merging a lot of files into a single file, you can use the following

```
library(XLConnect)
path <- "raw"
merge_file_name <- "csv/merged_file.csv"

filenames <- list.files(path= path, full.names=TRUE)

All <- lapply(filenames,function(filename){
  print(paste("Merging",filename,sep = " "))
  read.csv(filename)
})
df <- do.call(rbind.data.frame, All)
write.csv(df,merge_file_name)
```

you should save this code into a single R file similar to [example for sghousingprice](https://github.com/namkyodai/2022-UrbanComputation-SUTD/blob/main/notes/sg-houseprice/combineexcel.r)


## Group 2
- Dataset for group 2 is **dump-propertylistings-202203250237.sql**. Group 2 has worked already on PostgreSQL for this database and N Y M did presentation in the class. Now you can use the same data but using R to do pretty much the same jobs (e.g. using dplyr to summary different tables), then use ggplot2 to visualize some useful graphs.
- The group can read the data directly from PostgreSQL (load the data into R environment) or you can simply export the data into a csv file and read the csv file directly from R.

## Presentation time
Presentation time for each group is maximum 10 minutes. Other members of the groups should present instead of members who did presented already in week 2.


## Important notes

> since these are open questions, you can decide on which tables and which graphs to use. My suggestions are to use at least boxplot, bar, histogram, density, and scatterplot.

- If you have any issue, pls go to and post issue [https://github.com/namkyodai/2022-UrbanComputation-SUTD/issues](https://github.com/namkyodai/2022-UrbanComputation-SUTD/issues) so I or other members of the class can address timely and all of us can see the solutions
- You can also upload your solutions under issue

Cheers

Nam
