# 
#  The purpose of this script is to inspect the non-linear 
#  normalization of each sub-dataset 
# 
# 

# The following processes are standard, and are explained on the test-bed
rm(list = ls())

# Load Data
source('./utilities/load_and_omit_dataset.R')

## Softmax-Scaling 

# Choose a repository. i must bemetween 1~240 
i = 10
print(paste("Repo Name = ", rep_names[i]))
subset <- data_t[data_t$repository_name==rep_names[i],]

# Ditch columns 1 and 2, since theõ are non-numerical and add no value to the process. 
subset <- subset[,c(-1,-2)]

# Perform Scale and centering.
subset_sd = scale(x=subset, center = TRUE)   # x' = (x-E[x])/ó

#Perform Exp scale
subset_sm = scale(x=subset_sd, scale = rep(1/3,24)) # x' = x/2ó 
subset_sm <- 1/(1+exp(-subset_sm)) 

# plot stuff
par(mfcol=c(2,1),mar = rep(2, 4))
boxplot(subset_sd, main="SD-scaled sub-Dataset")
boxplot(subset_sm, main="Softmax-Scaled sub-Dataset")







