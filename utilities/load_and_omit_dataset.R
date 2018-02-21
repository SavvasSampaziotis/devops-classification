# The purpose of this script is to load the dataset and handle the NA values.
# 
# This is pretty much standard procedure, customised for the dataset given to us
# 
# This script performs: 
#   +Feature selection
#   +NA omission
# 

C = c("character", "character", "numeric", "numeric", "integer", "integer",
      "integer", "numeric", "numeric", "integer", "integer", "integer", "integer",
      "integer", "integer", "numeric", "integer", "integer", "integer", "integer",
      "integer", "integer", "integer", "integer", "integer", "integer", "integer")
dataset_g = read.csv("./data/dataset.csv", sep=';', header = TRUE, na.strings = c("NA"), colClasses = C)

# Feature No.4 ismore than 70% NaN, so it will be excluded from dataset.
data_t=dataset_g[,-4]

# Exlcude Records that have NA values
data_t=data_t[complete.cases(data_t),]

# Extract the names of the 240 repository in the dataset.
rep_names = unique(data_t[,2], incomparables = FALSE)

# certain repositories have NaN entries. These 
#  are Rep's No.30 and 90 and they are 
#  completely removed from the dataset.





