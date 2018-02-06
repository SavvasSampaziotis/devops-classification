#
# This script sums-up some of the basic data preprocessing performed on the Dev-Ops dataset. 
#
# This includes: 
#   Feature selection
#   NA-value omission
#   data Normalasation(per repository)
#   TODO: Outlier exclusion
#
# Run this script from project root-folder
#
#

rm(list = ls());

C = c("character", "character", "numeric", "numeric", "integer", "integer",
      "integer", "numeric", "numeric", "integer", "integer", "integer", "integer",
      "integer", "integer", "numeric", "integer", "integer", "integer", "integer",
      "integer", "integer", "integer", "integer", "integer", "integer", "integer")

dataset_g = read.csv("./data/dataset.csv", sep=';', header = TRUE, na.strings = c("NA"), colClasses = C)

# Feature No.4 ismore than 70% NaN, so it will be excluded from dataset.
data_t=dataset_g[,-4]

# Exlcude Records that have NA values
data_t=data_t[complete.cases(data_t),]


# Each repository sub-dataset is scaled individually. 
rep_names = unique(data_t[,2], incomparables = FALSE)
scaled_data=data_t[,3:26]
for(i in 1:240)
{
  # This sub-dataset contains all the records from the i-th repository.
  subset <- data_t[data_t$repository_name==rep_names[i],]
  
  # Outlier Removal
  # TODO:
  
  colNums=which(data_t$repository_name==rep_names[i])
  if(sum(colNums)>0)
  {
    
    scaled_data[colNums,] <- scale(scaled_data[colNums,], center = FALSE)
    
  }
}

# Scale normalises each data-column by its variance. More NaN values may be generated as result.
omited_data=colSums(is.na(scaled_data))
scaled_data=scaled_data[complete.cases(scaled_data),]
# print(x=c('Number of ommited scaled data:', omited_data))

# Remove all variables from workspace EXCPET scaled_data
# rm(list = ls()[!(ls()=="scaled_data")])






