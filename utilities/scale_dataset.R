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
# source('./utilities/softmax_norm.R')


softmax_norm <- function(subset, r){
  
  temp = subset
  
  # Perform SD-Scale and Centering.
  subset_sc = scale(x=subset, center = TRUE)   # x' = (x-E[x])/sd(x)
  
  complete_cases =complete.cases(subset_sc)
  if(sum(complete_cases)==0)
  {
    # Case of zero variance for all features... 
    return(scale(x=subset, center = TRUE, scale = rep(1,24)))
  }
    
  
  subset_sc = subset_sc[complete_cases,]
  
  # Perform Exp scale
  subset_sc = scale(x=subset_sc, scale = rep(r,24)) # x' = x/r/sd(x)
  subset_sc <- 1/(1+exp(-subset_sc))
  
  # par(mfcol=c(2,1),mar = rep(2, 4))
  # boxplot(temp)
  # boxplot(subset_sc)
  # 
  return(subset_sc)
}


X = rep(1,24)

scaled_data=data_t[,3:26]
for(i in 1:length(rep_names))
{
  # This sub-dataset contains all the records from the i-th repository.
  # subset <- data_t[data_t$repository_name==rep_names[i],]
  
  colNums=which(data_t$repository_name==rep_names[i])
  if(sum(colNums)>0)
  {
    
    # scaled_data[colNums,] <- scale(scaled_data[colNums,], center = FALSE)
    
    scaled_data[colNums,] <- softmax_norm(scaled_data[colNums,], r = 2)
 
    
    for(f in 3:26)
    {
      
      std_feat = var(x=data_t[colNums,f])
      
      # TODO: This should be removed      
      if(is.na(std_feat))
      {
        # X[f] = 0
        # print(f)
      }
      else
      {

        X[f] = X[f] & (std_feat > 0.1)
          
      }


    }
    
  }
  else
    print(rep_names[i])
  
 
  
  # print("savvas")
}

X = which(abs(scaled_data[,1])>1)
scaled_data = scaled_data[-X,]

# Scale normalises each data-column by its variance. More NaN values may be generated as result.
omited_data=colSums(is.na(scaled_data))
# print(x=c('Number of ommited scaled data:', omited_data))

plot(scaled_data)

