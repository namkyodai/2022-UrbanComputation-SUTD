#https://data.cdrc.ac.uk/dataset/introduction-spatial-data-analysis-and-visualisation-r
# loading data
Ethnicity <- read.csv("Camden/tables/KS201EW_oa11.csv")
Rooms <- read.csv("Camden/tables/KS403EW_oa11.csv")
Qualifications <-read.csv("Camden/tables/KS501EW_oa11.csv")
Employment <-read.csv("Camden/tables/KS601EW_oa11.csv")
#View(Employment)
names(Employment)

Ethnicity <- Ethnicity[, c(1, 21)] #White: English/Welsh/Scottish/Northern Irish/British

Rooms <- Rooms[, c(1, 13)] # Occupancy rating (bedrooms) of -1 or less

Employment <- Employment[, c(1, 20)] # Economically active: Unemployed

Qualifications <- Qualifications[, c(1, 20)] # Highest level of qualification: Level 4 qualifications and above

#rename

names(Employment)[2] <- "Unemployed"

names(Ethnicity)<- c("OA", "White_British")
names(Rooms)<- c("OA", "Low_Occupancy")
names(Employment)<- c("OA", "Unemployed")
names(Qualifications)<- c("OA", "Qualification")


#1 Merge Ethnicity and Rooms to create a new object called "merged_data_1"
merged_data_1 <- merge(Ethnicity, Rooms, by="OA")

#2 Merge the "merged_data_1" object with Employment to create a new merged data object
merged_data_2 <- merge(merged_data_1, Employment, by="OA")

#3 Merge the "merged_data_2" object with Qualifications to create a new data object
Census.Data <- merge(merged_data_2, Qualifications, by="OA")

#4 Remove the "merged_data" objects as we won't need them anymore
rm(merged_data_1, merged_data_2)
#write.csv(Census.Data, "Camden/practical_data.csv", row.names=F)







