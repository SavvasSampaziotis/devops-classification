
rm(list = ls());

C = c("character", "character", "numeric", "numeric", "integer", "integer",
  "integer", "numeric", "numeric", "integer", "integer", "integer", "integer",
  "integer", "integer", "numeric", "integer", "integer", "integer", "integer",
  "integer", "integer", "integer", "integer", "integer", "integer", "integer")

dataset_g = read.csv("../data/dataset.csv", sep=';', header = TRUE, na.strings = c("NA"), colClasses = C)
N = nrow(dataset_g)

# Extract the names of the 240 repository in the dataset.
rep_names = unique(dataset_g[,2], incomparables = FALSE)


vec = vector(length = 240)
repStats = data.frame( numRows=vec, numNA=vec )

# Choose a repository. i must bemetween 1~240 
for(i in 1:240)
{
  subset <- dataset_g[dataset_g$repository_name==rep_names[i],]
  
  repStats$numRows[i] = 100*nrow(subset)/N
  
  repStats$numNA[i] = 100*sum(is.na(subset))/N/27
}  


par(mfcol=c(1,2))



barplot( repStats$numRows, 
         xlab = "repo-id", 
         ylab = "% of rows", 
         main = "Contribution of each dataset in rows")

barplot( repStats$numNA, 
         xlab = "repo-id", 
         ylab = "% of NA nums", 
         main = "Number of NA")




