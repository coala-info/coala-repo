# Code example from 'ssPATHS' vignette. See references/ for full tutorial.

### R code from vignette source 'ssPATHS.Rnw'

###################################################
### code chunk number 1: ssPATHS.Rnw:22-23
###################################################
options(width=60)


###################################################
### code chunk number 2: ssPATHS.Rnw:25-26
###################################################
options(continue=" ")


###################################################
### code chunk number 3: ssPATHS.Rnw:42-45
###################################################
library("ROCR")
library("ggplot2")
library("ssPATHS")


###################################################
### code chunk number 4: ssPATHS.Rnw:49-51
###################################################

data(tcga_expr_df)


###################################################
### code chunk number 5: ssPATHS.Rnw:57-58
###################################################
tcga_expr_df[1:6,1:5]


###################################################
### code chunk number 6: ssPATHS.Rnw:62-67
###################################################
tcga_se <- SummarizedExperiment(t(tcga_expr_df[ , -(1:4)]),
                                colData=tcga_expr_df[ , 2:4])
colnames(tcga_se) <- tcga_expr_df$tcga_id
colData(tcga_se)$sample_id <- tcga_expr_df$tcga_id



###################################################
### code chunk number 7: ssPATHS.Rnw:75-78
###################################################

hypoxia_gene_ids <- get_hypoxia_genes()
hypoxia_gene_ids <- intersect(hypoxia_gene_ids, rownames(tcga_se))


###################################################
### code chunk number 8: ssPATHS.Rnw:88-91
###################################################

colData(tcga_se)$Y <- ifelse(colData(tcga_se)$is_normal, 0, 1)



###################################################
### code chunk number 9: ssPATHS.Rnw:104-108
###################################################

res <- get_gene_weights(tcga_se, hypoxia_gene_ids, unidirectional=TRUE)
gene_weights <- res[[1]]
sample_scores <- res[[2]]


###################################################
### code chunk number 10: ssPATHS.Rnw:112-121
###################################################

training_res <- get_classification_accuracy(sample_scores, positive_val=1)

# plot the ROC curve
plot(training_res[[4]], col="blue", ylim=c(0, 1))
roc_text <- paste("AUC:", round(training_res$auc_roc,3))

legend(0.1,0.8, roc_text,
       border="white",cex=1,box.col = "white")


###################################################
### code chunk number 11: ssPATHS.Rnw:124-130
###################################################

# plot the PR curve
plot(training_res[[3]], col="orange", ylim=c(0, 1))
pr_text <- paste("AUC:", round(training_res$auc_pr,3))
legend(0.1,0.8, pr_text,
       border="white",cex=1,box.col = "white")


###################################################
### code chunk number 12: ssPATHS.Rnw:136-143
###################################################
data(new_samp_df)
new_samp_se <- SummarizedExperiment(t(new_samp_df[ , -(1)]),
                                    colData=new_samp_df[ , 1, drop=FALSE])
colnames(colData(new_samp_se)) <- "sample_id"

new_score_df <- get_new_samp_score(gene_weights, new_samp_se)
new_score_df


###################################################
### code chunk number 13: ssPATHS.Rnw:152-170
###################################################

plot_scores <- function(hif_scores){

    # format the sample IDS
    hif_scores$sample_type <- substr(hif_scores$sample_id, 1,
                                  nchar((hif_scores$sample_id))-2)
    colnames(hif_scores)[2] <- "pathway_score"

    gg <- ggplot(hif_scores, aes(x=sample_type, y=pathway_score,
                                  fill=sample_type)) +
        geom_boxplot() +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        theme_bw()

        return(gg)
}
gg <- plot_scores(as.data.frame(new_score_df))
print(gg)


