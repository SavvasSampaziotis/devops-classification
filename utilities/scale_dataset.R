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

source('./utilities/load_and_omit_dataset.R')


r = 1
scaled_data=data_t[,3:26]

X = 0

for(i in 1:length(rep_names))
{
  # This vector contains all the indeces from the i-th repository.
  colNums=which(data_t$repository_name==rep_names[i])
  data_temp <- data_t[colNums,3:26]
  
  # Perform SD-Scale and Centering. # Some records may contain NAN after scale and will be excluded
  data_temp <- scale(x=data_temp, center = TRUE)   # x' = (x-E[x])/sd(x)
 
  # Perform Exp scale
  data_temp = scale(x=data_temp, scale = rep(r,24)) # x' = x/r/sd(x)
  data_temp <- 1/(1+exp(-data_temp))
  
  scaled_data[colNums,]=data_temp
}


# Scale normalises each data-column by its variance. More NaN values may be generated as result.
omited_data= colSums(is.na(scaled_data))

complete_cases = complete.cases(scaled_data)
scaled_data = scaled_data[complete_cases,]
print(5057-sum(complete_cases))

# boxplot(data_t[,6:12], main = "Original Dataset")
# boxplot(scaled_data, main = "Scaled Dataset")4




