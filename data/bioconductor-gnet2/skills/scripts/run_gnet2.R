# Code example from 'run_gnet2' vignette. See references/ for full tutorial.

## ----setup,echo = FALSE, include = TRUE---------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----load_packages, message=FALSE, warning=FALSE, include=FALSE---------------
library(GNET2)

## ----echo = TRUE--------------------------------------------------------------
set.seed(2)
init_group_num = 8
init_method = 'boosting'
exp_data <- matrix(rnorm(300*12),300,12)
reg_names <- paste0('TF',1:20)
rownames(exp_data) <- c(reg_names,paste0('gene',1:(nrow(exp_data)-length(reg_names))))
colnames(exp_data) <- paste0('condition_',1:ncol(exp_data))

## ----echo=TRUE----------------------------------------------------------------
gnet_result <- gnet(exp_data,reg_names,init_method,init_group_num,heuristic = TRUE)

## ----echo=TRUE,fig.width=10, fig.height=12------------------------------------
plot_gene_group(gnet_result,group_idx = 1,plot_leaf_labels = T)

## ----echo=TRUE,fig.width=10, fig.height=12------------------------------------
exp_labels = rep(paste0('Exp_',1:4),each = 3)
plot_gene_group(gnet_result,group_idx = 1,group_labels = exp_labels)

## ----echo=TRUE,fig.width=10, fig.height=12------------------------------------
exp_labels_factor = as.numeric(factor(exp_labels))

print('Similarity to categorical experimental conditions of each module:')
print(similarity_score(gnet_result,exp_labels_factor))

print('Similarity to ordinal experimental conditions of each module:')
print(similarity_score(gnet_result,exp_labels_factor),ranked=TRUE)

## ----echo=TRUE,fig.width=8, fig.height=8--------------------------------------
plot_tree(gnet_result,group_idx = 1)

## ----echo=TRUE,fig.width=8, fig.height=8--------------------------------------
group_above_kn <- plot_group_correlation(gnet_result)
print(group_above_kn)

## ----echo=TRUE,fig.width=8, fig.height=8--------------------------------------
print('Total number of modules:')
print(gnet_result$modules_count)

## ----echo=TRUE,fig.width=8, fig.height=8--------------------------------------
group_index = 1
print('Regulators in module 1:')
print(gnet_result$regulators[[group_index]])
print('Targets in module 1:')
print(gnet_result$target_genes[[group_index]])

## ----echo=TRUE,fig.width=8, fig.height=8--------------------------------------
mat <- extract_edges(gnet_result)
print(dim(mat))

## ----echo=TRUE----------------------------------------------------------------
sessionInfo()

