# Code example from 'diffuStats' vignette. See references/ for full tutorial.

### R code from vignette source 'diffuStats.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: 01_imports
###################################################
# Core
library(igraph)
library(diffuStats)

# Plotting
library(ggplot2)
library(ggsci)

# Data
library(igraphdata)
data(yeast)
set.seed(1)


###################################################
### code chunk number 3: 02_data1
###################################################
summary(yeast)


###################################################
### code chunk number 4: 02_data2
###################################################
yeast <- diffuStats::largest_cc(yeast)


###################################################
### code chunk number 5: 02_data3
###################################################
head(V(yeast)$name)


###################################################
### code chunk number 6: 02_data4
###################################################
head(V(yeast)$Description)


###################################################
### code chunk number 7: 02_data5
###################################################
table_classes <- table(V(yeast)$Class, useNA = "always")
table_classes


###################################################
### code chunk number 8: 02_data6
###################################################
head(yeast$Classes)


###################################################
### code chunk number 9: 02_data7
###################################################
table(E(yeast)$Confidence)


###################################################
### code chunk number 10: 03_datasplit
###################################################
perc <- .5

# Transport and sensing is class A
nodes_A <- V(yeast)[Class %in% "A"]$name
nodes_unlabelled <- V(yeast)[Class %in% c(NA, "U")]$name
nodes_notA <- setdiff(V(yeast)$name, c(nodes_A, nodes_unlabelled))

# Known labels
known_A <- sample(nodes_A, perc*length(nodes_A))
known_notA <- sample(nodes_notA, perc*length(nodes_notA))
known <- c(known_A, known_notA)

# Unknown target nodes
target_A <- setdiff(nodes_A, known_A)
target_notA <- setdiff(nodes_notA, known_notA)
target <- c(target_A, target_notA)
target_id <- V(yeast)$name %in% target

# True scores
scores_true <- V(yeast)$Class %in% "A"


###################################################
### code chunk number 11: 03_diffuse
###################################################
# Vector of scores
scores_A <- setNames((known %in% known_A)*1, known)

# Diffusion
diff <- diffuStats::diffuse(
    yeast,
    scores = scores_A,
    method = "raw"
)


###################################################
### code chunk number 12: 03_diff1
###################################################
head(diff)


###################################################
### code chunk number 13: 03_diff2
###################################################
# Compare scores
df_plot <- data.frame(
    Protein = V(yeast)$name,
    Class = ifelse(scores_true, "Transport and sensing", "Other"),
    DiffusionScore = diff,
    Target = target_id,
    Method = "raw",
    stringsAsFactors = FALSE
)

ggplot(subset(df_plot, Target), aes(x = Class, y = DiffusionScore)) +
    geom_boxplot(aes(fill = Method)) +
    theme_bw() +
    scale_y_log10() +
    xlab("Protein class") +
    ylab("Diffusion score") +
    ggtitle("Target proteins in 'transport and sensing'")


###################################################
### code chunk number 14: 03_diff3
###################################################
# Top scores subnetwork
vertex_ids <- head(order(df_plot$DiffusionScore, decreasing = TRUE), 30)
yeast_top <- igraph::induced.subgraph(yeast, vertex_ids)

# Overlay desired properties
# use tkplot for interactive plotting
igraph::plot.igraph(
    yeast_top,
    vertex.color = diffuStats::scores2colours(
        df_plot$DiffusionScore[vertex_ids]),
    vertex.shape = diffuStats::scores2shapes(
        df_plot$Protein[vertex_ids] %in% known_A),
    vertex.label.color = "gray10",
    main = "Top 30 proteins from diffusion scores"
)


###################################################
### code chunk number 15: 04_kernel
###################################################
K_rl <- diffuStats::regularisedLaplacianKernel(yeast)


###################################################
### code chunk number 16: 04_diff
###################################################
list_methods <- c("raw", "ml", "gm", "ber_s", "ber_p", "mc", "z")

df_diff <- diffuse_grid(
    K = K_rl,
    scores = scores_A,
    grid_param = expand.grid(method = list_methods),
    n.perm = 1000 
)
df_diff$transport <- ifelse(
    df_diff$node_id %in% nodes_A, 
    "Transport and sensing", 
    "Other"
)


###################################################
### code chunk number 17: 04_plot
###################################################
df_plot <- subset(df_diff, node_id %in% target)
ggplot(df_plot, aes(x = transport, y = node_score)) +
    geom_boxplot(aes(fill = method)) +
    scale_fill_npg() +
    theme_bw() +
    theme(axis.text.x = element_text(
        angle = 45, vjust = 1, hjust = 1)) +
    facet_wrap( ~ method, nrow = 1, scales = "free") +
    xlab("Protein class") +
    ylab("Diffusion score") +
    ggtitle("Target proteins scores in 'transport and sensing'")


###################################################
### code chunk number 18: 05_scores
###################################################
# All classes except NA and unlabelled
names_classes <- setdiff(names(table_classes), c("U", NA))

# matrix format
mat_classes <- sapply(
    names_classes,
    function(class) {
        V(yeast)$Class %in% class
    }
)*1
rownames(mat_classes) <- V(yeast)$name
colnames(mat_classes) <- names_classes


###################################################
### code chunk number 19: 05_perf
###################################################
list_methods <- c("raw", "ml", "gm", "ber_s", "ber_p", "mc", "z")

df_methods <- perf(
    K = K_rl,
    scores = mat_classes[known, ],
    validation = mat_classes[target, ],
    grid_param = expand.grid(
        method = list_methods,
        stringsAsFactors = FALSE),
    n.perm = 1000
)


###################################################
### code chunk number 20: 05_plot
###################################################
ggplot(df_methods, aes(x = method, y = auc)) +
    geom_boxplot(aes(fill = method)) +
    scale_fill_npg() +
    theme_bw() +
    xlab("Method") +
    ylab("Area under the curve") +
    ggtitle("Methods performance in all categories")


###################################################
### code chunk number 21: 05_plotsave (eval = FALSE)
###################################################
## # Save plot for manuscript
## # # library(extrafont)
## setEPS()
## postscript("data-raw/BoxplotAUC.eps", width = 3.38, height = 3.38)
## ggplot(df_methods, aes(x = method, y = auc)) +
##     # geom_boxplot(aes(fill = method), outlier.size = 1) +
##     geom_boxplot(outlier.size = 1) +
##     scale_fill_npg(name = "Method") +
##     theme_bw() +
##     xlab("Method") +
##     ylab("Area under the curve") +
##     # coord_fixed() +
##     ggtitle("Benchmark of protein categories") +
##     theme(
##         text = element_text(size = 10),
##         axis.text.x = element_text(
##             size = 8, angle = 45, vjust = 1,
##             hjust = 1, color = "black"),
##         axis.text.y = element_text(size = 8, color = "black"),
##         plot.title = element_text(size = 12, hjust = .5))
## dev.off()
## 
## # Build table for manuscript
## df_perf <- reshape2::acast(df_methods, Column~method, value.var = "auc")
## df_test <- perf_wilcox(
##     df_perf, 
##     digits_p = 1, 
##     adjust = function(p) p.adjust(p, method = "fdr"), 
##     scientific = FALSE)
## xtable::xtable(df_test)


###################################################
### code chunk number 22: 05_test
###################################################
# Format the data
df_perf <- reshape2::acast(df_methods, Column~method, value.var = "auc")
# Compute the comparison matrix
df_test <- perf_wilcox(
    df_perf, 
    digits_p = 1, 
    adjust = function(p) p.adjust(p, method = "fdr"), 
    scientific = FALSE)
knitr::kable(df_test, format = "latex")


###################################################
### code chunk number 23: sessioninfo
###################################################
toLatex(sessionInfo())


