
rm(list = ls());

C = c("character", "character", "numeric", "numeric", "integer", "integer",
  "integer", "numeric", "numeric", "integer", "integer", "integer", "integer",
  "integer", "integer", "numeric", "integer", "integer", "integer", "integer",
  "integer", "integer", "integer", "integer", "integer", "integer", "integer")

dataset_g = read.csv("./data/dataset.csv", sep=';', header = TRUE, na.strings = c("NA"), colClasses = C)
N = nrow(dataset_g)
D = ncol(dataset_g)
# Extract the names of the 240 repository in the dataset.
rep_names = unique(dataset_g[,2], incomparables = FALSE)


vec = vector(length = 240)
repStats = data.frame( numRows=vec, numNAN=vec, numNANtuples = vec, numNANcol  = vec)

# Choose a repository. i must bemetween 1~240 
for(i in 1:240)
{
  subset <- dataset_g[dataset_g$repository_name==rep_names[i],]
  
  repStats$numRows[i] = 100*nrow(subset)/N
  
  repStats$numNAN[i] = 100*sum(is.na(subset))/N/27
  
  # Count all tuples that have at least one NaN element
  temp_count = 0
  for(j in 1:nrow(subset))
  {
    temp_count = temp_count + any(is.na(subset[j,]))
  }
  repStats$numNANtuples[i] = temp_count/nrow(subset)*100
  
}  

# Count NaN per column, for the entire dataset. Incase o 
numNANcol_g = colSums(is.na(dataset_g))



# par(mfcol=c(1,2))


# barplot( repStats$numRows, 
#          xlab = "repo-id", 
#          ylab = "% of rows", 
#          main = "Contribution of records per repository")

barplot( repStats$numNANtuples, 
         xlab = "repo-id", 
         ylab = "% of rows", 
         main = "Records with at least 1 NaN element per Repository")




