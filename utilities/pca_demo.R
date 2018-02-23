
# domain_feats = c(2:6) # Issues-Domain
domain_feats = 2:6
pca_model = prcomp(scaled_data[,domain_feats])

pca_select = 1:2
eigenvalues = pca_model$sdev
info_loss = sum(eigenvalues[-pca_select])/sum(eigenvalues)
print(cat("Info Loss",info_loss,"\n"))


plot(pca_model)
# pairs(scaled_data[,domain_feats])
