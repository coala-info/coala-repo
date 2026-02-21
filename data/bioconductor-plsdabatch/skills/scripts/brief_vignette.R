# Code example from 'brief_vignette' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(dpi = 70, echo = TRUE, warning = FALSE, message = FALSE, 
                    eval = TRUE, fig.show = TRUE, fig.width = 6, 
                    fig.height = 4, fig.align ='center', 
                    out.width = '60%', cache = FALSE)

## -----------------------------------------------------------------------------
# CRAN
library(pheatmap)
library(vegan)
library(gridExtra)

# Bioconductor
library(mixOmics)
library(Biobase)
library(TreeSummarizedExperiment)
library(PLSDAbatch)

# print package versions
package.version('pheatmap')
package.version('vegan')
package.version('gridExtra')
package.version('mixOmics')
package.version('Biobase')
package.version('PLSDAbatch')

## -----------------------------------------------------------------------------
# AD data
data('AD_data') 
ad.count <- assays(AD_data$FullData)$Count
dim(ad.count)

ad.metadata <- rowData(AD_data$FullData)
ad.batch = factor(ad.metadata$sequencing_run_date, 
                levels = unique(ad.metadata$sequencing_run_date))
ad.trt = as.factor(ad.metadata$initial_phenol_concentration.regroup)
names(ad.batch) <- names(ad.trt) <- rownames(ad.metadata)

## -----------------------------------------------------------------------------
ad.filter.res <- PreFL(data = ad.count)
ad.filter <- ad.filter.res$data.filter
dim(ad.filter)

# zero proportion before filtering
ad.filter.res$zero.prob
# zero proportion after filtering
sum(ad.filter == 0)/(nrow(ad.filter) * ncol(ad.filter))

## -----------------------------------------------------------------------------
ad.clr <- logratio.transfo(X = ad.filter, logratio = 'CLR', offset = 1) 
class(ad.clr) = 'matrix'

## ----ADpcaBefore, out.width = '80%', fig.align = 'center', fig.cap = 'The PCA sample plot with densities in the AD data.'----
# AD data
ad.pca.before <- pca(ad.clr, ncomp = 3, scale = TRUE)

Scatter_Density(object = ad.pca.before, batch = ad.batch, trt = ad.trt, 
                title = 'AD data', trt.legend.title = 'Phenol conc.')

## ----ADboxBefore, out.width = '80%', fig.align = 'center', fig.cap = 'Boxplots of sample values in "OTU28" before batch effect correction in the AD data.'----
ad.OTU.name <- selectVar(ad.pca.before, comp = 1)$name[1]
ad.OTU_batch <- data.frame(value = ad.clr[,ad.OTU.name], batch = ad.batch)
box_plot(df = ad.OTU_batch, title = paste(ad.OTU.name, '(AD data)'), 
        x.angle = 30)

## ----ADdensityBefore, out.width = '80%', fig.align = 'center', fig.cap = 'Density plots of sample values in "OTU28" before batch effect correction in the AD data.'----
density_plot(df = ad.OTU_batch, title = paste(ad.OTU.name, '(AD data)'))

## -----------------------------------------------------------------------------
# reference batch: 14/04/2016
ad.batch <- relevel(x = ad.batch, ref = '14/04/2016')

ad.OTU.lm <- linear_regres(data = ad.clr[,ad.OTU.name], 
                            trt = ad.trt, batch.fix = ad.batch, 
                            type = 'linear model')
summary(ad.OTU.lm$model$data)

# reference batch: 21/09/2017
ad.batch <- relevel(x = ad.batch, ref = '21/09/2017')

ad.OTU.lm <- linear_regres(data = ad.clr[,ad.OTU.name], 
                            trt = ad.trt, batch.fix = ad.batch, 
                            type = 'linear model')
summary(ad.OTU.lm$model$data)

## ----ADheatmap, out.width = '90%', fig.align = 'center', fig.cap = 'Hierarchical clustering for samples in the AD data.'----
# scale the clr data on both OTUs and samples
ad.clr.s <- scale(ad.clr, center = TRUE, scale = TRUE)
ad.clr.ss <- scale(t(ad.clr.s), center = TRUE, scale = TRUE)

ad.anno_col <- data.frame(Batch = ad.batch, Treatment = ad.trt)
ad.anno_colors <- list(Batch = color.mixo(seq_len(5)), 
                        Treatment = pb_color(seq_len(2)))
names(ad.anno_colors$Batch) = levels(ad.batch)
names(ad.anno_colors$Treatment) = levels(ad.trt)

pheatmap(ad.clr.ss, 
        cluster_rows = FALSE, 
        fontsize_row = 4, 
        fontsize_col = 6,
        fontsize = 8,
        clustering_distance_rows = 'euclidean',
        clustering_method = 'ward.D',
        treeheight_row = 30,
        annotation_col = ad.anno_col,
        annotation_colors = ad.anno_colors,
        border_color = 'NA',
        main = 'AD data - Scaled')


## -----------------------------------------------------------------------------
# AD data
ad.factors.df <- data.frame(trt = ad.trt, batch = ad.batch)
class(ad.clr) <- 'matrix'
ad.rda.before <- varpart(ad.clr, ~ trt, ~ batch, 
                        data = ad.factors.df, scale = TRUE)
ad.rda.before$part$indfract

## -----------------------------------------------------------------------------
# estimate the number of treatment components
ad.trt.tune <- plsda(X = ad.clr, Y = ad.trt, ncomp = 5)
ad.trt.tune$prop_expl_var #1

## -----------------------------------------------------------------------------
# estimate the number of batch components
ad.batch.tune <- PLSDA_batch(X = ad.clr, 
                            Y.trt = ad.trt, Y.bat = ad.batch,
                            ncomp.trt = 1, ncomp.bat = 10)
ad.batch.tune$explained_variance.bat #4
sum(ad.batch.tune$explained_variance.bat$Y[seq_len(4)])


## -----------------------------------------------------------------------------
ad.PLSDA_batch.res <- PLSDA_batch(X = ad.clr, 
                                Y.trt = ad.trt, Y.bat = ad.batch,
                                ncomp.trt = 1, ncomp.bat = 4)
ad.PLSDA_batch <- ad.PLSDA_batch.res$X.nobatch

## ----eval = F-----------------------------------------------------------------
# # estimate the number of variables to select per treatment component
# set.seed(777)
# ad.test.keepX = c(seq(1, 10, 1), seq(20, 100, 10),
#                 seq(150, 231, 50), 231)
# ad.trt.tune.v <- tune.splsda(X = ad.clr, Y = ad.trt,
#                             ncomp = 1, test.keepX = ad.test.keepX,
#                             validation = 'Mfold', folds = 4,
#                             nrepeat = 50)
# ad.trt.tune.v$choice.keepX #100
# 

## -----------------------------------------------------------------------------
# estimate the number of batch components
ad.batch.tune <- PLSDA_batch(X = ad.clr, 
                            Y.trt = ad.trt, Y.bat = ad.batch,
                            ncomp.trt = 1, keepX.trt = 100,
                            ncomp.bat = 10)
ad.batch.tune$explained_variance.bat #4
sum(ad.batch.tune$explained_variance.bat$Y[seq_len(4)])

## -----------------------------------------------------------------------------
ad.sPLSDA_batch.res <- PLSDA_batch(X = ad.clr, 
                                Y.trt = ad.trt, Y.bat = ad.batch,
                                ncomp.trt = 1, keepX.trt = 100,
                                ncomp.bat = 4)
ad.sPLSDA_batch <- ad.sPLSDA_batch.res$X.nobatch

## -----------------------------------------------------------------------------
ad.pca.before <- pca(ad.clr, ncomp = 3, scale = TRUE)
ad.pca.PLSDA_batch <- pca(ad.PLSDA_batch, ncomp = 3, scale = TRUE)
ad.pca.sPLSDA_batch <- pca(ad.sPLSDA_batch, ncomp = 3, scale = TRUE)

## ----fig.show='hide'----------------------------------------------------------
# order batches
ad.batch = factor(ad.metadata$sequencing_run_date, 
                levels = unique(ad.metadata$sequencing_run_date))

ad.pca.before.plot <- Scatter_Density(object = ad.pca.before, 
                                    batch = ad.batch, 
                                    trt = ad.trt, 
                                    title = 'Before correction')
ad.pca.PLSDA_batch.plot <- Scatter_Density(object = ad.pca.PLSDA_batch, 
                                        batch = ad.batch, 
                                        trt = ad.trt, 
                                        title = 'PLSDA-batch')
ad.pca.sPLSDA_batch.plot <- Scatter_Density(object = ad.pca.sPLSDA_batch, 
                                            batch = ad.batch, 
                                            trt = ad.trt, 
                                            title = 'sPLSDA-batch')


## ----ADpca, fig.height = 12, fig.width = 6, out.width = '80%', echo = FALSE, fig.align = 'center', fig.cap = 'The PCA sample plots with densities before and after batch effect correction in the AD data.'----
grid.arrange(ad.pca.before.plot, 
            ad.pca.PLSDA_batch.plot, 
            ad.pca.sPLSDA_batch.plot, ncol = 1)

## ----ADprda, fig.height = 6, fig.width = 4, out.width = '80%', fig.align = 'center', fig.cap = 'Global explained variance before and after batch effect correction for the AD data.'----
# AD data
ad.corrected.list <- list(`Before correction` = ad.clr, 
                        `PLSDA-batch` = ad.PLSDA_batch, 
                        `sPLSDA-batch` = ad.sPLSDA_batch)

ad.prop.df <- data.frame(Treatment = NA, Batch = NA, 
                        Intersection = NA, 
                        Residuals = NA) 
for(i in seq_len(length(ad.corrected.list))){
    rda.res = varpart(ad.corrected.list[[i]], ~ trt, ~ batch,
                    data = ad.factors.df, scale = TRUE)
    ad.prop.df[i, ] <- rda.res$part$indfract$Adj.R.squared}

rownames(ad.prop.df) = names(ad.corrected.list)

ad.prop.df <- ad.prop.df[, c(1,3,2,4)]

ad.prop.df[ad.prop.df < 0] = 0
ad.prop.df <- as.data.frame(t(apply(ad.prop.df, 1, 
                                    function(x){x/sum(x)})))

partVar_plot(prop.df = ad.prop.df)

## ----ADr21, fig.height = 6, fig.width = 8, out.width = '100%', fig.align = 'center', fig.cap = 'AD study: $R^2$ values for each microbial variable before and after batch effect correction.'----
# AD data
# scale
ad.corr_scale.list <- lapply(ad.corrected.list, 
                            function(x){apply(x, 2, scale)})

ad.r_values.list <- list()
for(i in seq_len(length(ad.corr_scale.list))){
    ad.r_values <- data.frame(trt = NA, batch = NA)
    for(c in seq_len(ncol(ad.corr_scale.list[[i]]))){
        ad.fit.res.trt <- lm(ad.corr_scale.list[[i]][,c] ~ ad.trt)
        ad.r_values[c,1] <- summary(ad.fit.res.trt)$r.squared
        ad.fit.res.batch <- lm(ad.corr_scale.list[[i]][,c] ~ ad.batch)
        ad.r_values[c,2] <- summary(ad.fit.res.batch)$r.squared
    }
    ad.r_values.list[[i]] <- ad.r_values
}
names(ad.r_values.list) <- names(ad.corr_scale.list)

ad.boxp.list <- list()
for(i in seq_len(length(ad.r_values.list))){
    ad.boxp.list[[i]] <- 
        data.frame(r2 = c(ad.r_values.list[[i]][ ,'trt'],
                        ad.r_values.list[[i]][ ,'batch']), 
                    Effects = as.factor(rep(c('Treatment','Batch'), 
                                        each = 231)))
}
names(ad.boxp.list) <- names(ad.r_values.list)

ad.r2.boxp <- rbind(ad.boxp.list$`Before correction`,
                    ad.boxp.list$removeBatchEffect,
                    ad.boxp.list$ComBat,
                    ad.boxp.list$`PLSDA-batch`,
                    ad.boxp.list$`sPLSDA-batch`,
                    ad.boxp.list$`Percentile Normalisation`,
                    ad.boxp.list$RUVIII)

ad.r2.boxp$methods <- rep(c('Before correction', 'PLSDA-batch', 'sPLSDA-batch'),
                        each = 462)

ad.r2.boxp$methods <- factor(ad.r2.boxp$methods, 
                            levels = unique(ad.r2.boxp$methods))

ggplot(ad.r2.boxp, aes(x = Effects, y = r2, fill = Effects)) +
    geom_boxplot(alpha = 0.80) +
    theme_bw() + 
    theme(text = element_text(size = 18),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.text.x = element_text(angle = 60, hjust = 1, size = 18),
            axis.text.y = element_text(size = 18),
            panel.grid.minor.x = element_blank(),
            panel.grid.major.x = element_blank(),
            legend.position = "right") + facet_grid( ~ methods) + 
    scale_fill_manual(values=pb_color(c(12,14))) 


## ----ADr22, fig.height = 6, fig.width = 8, out.width = '100%', fig.align = 'center', fig.cap = 'AD study: the sum of $R^2$ values for each microbial variable before and after batch effect correction.'----
##################################
ad.barp.list <- list()
for(i in seq_len(length(ad.r_values.list))){
    ad.barp.list[[i]] <- data.frame(r2 = c(sum(ad.r_values.list[[i]][ ,'trt']),
                                        sum(ad.r_values.list[[i]][ ,'batch'])), 
                                    Effects = c('Treatment','Batch'))
}
names(ad.barp.list) <- names(ad.r_values.list)

ad.r2.barp <- rbind(ad.barp.list$`Before correction`,
                    ad.barp.list$removeBatchEffect,
                    ad.barp.list$ComBat,
                    ad.barp.list$`PLSDA-batch`,
                    ad.barp.list$`sPLSDA-batch`,
                    ad.barp.list$`Percentile Normalisation`,
                    ad.barp.list$RUVIII)


ad.r2.barp$methods <- rep(c('Before correction', 'PLSDA-batch', 'sPLSDA-batch'),
                        each = 2)

ad.r2.barp$methods <- factor(ad.r2.barp$methods, 
                            levels = unique(ad.r2.barp$methods))


ggplot(ad.r2.barp, aes(x = Effects, y = r2, fill = Effects)) +
    geom_bar(stat="identity") + 
    theme_bw() + 
    theme(text = element_text(size = 18),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.text.x = element_text(angle = 60, hjust = 1, size = 18),
            axis.text.y = element_text(size = 18),
            panel.grid.minor.x = element_blank(),
            panel.grid.major.x = element_blank(),
            legend.position = "right") + facet_grid( ~ methods) + 
    scale_fill_manual(values=pb_color(c(12,14)))


## ----ADalignment, fig.height = 3, out.width = '90%', fig.align = 'center', fig.cap = 'Comparison of alignment scores before and after batch effect correction using different methods for the AD data.'----
# AD data
ad.scores <- c()
names(ad.batch) <- rownames(ad.clr)
for(i in seq_len(length(ad.corrected.list))){
    res <- alignment_score(data = ad.corrected.list[[i]], 
                            batch = ad.batch, 
                            var = 0.95, 
                            k = 8, 
                            ncomp = 50)
    ad.scores <- c(ad.scores, res)
}

ad.scores.df <- data.frame(scores = ad.scores, 
                            methods = names(ad.corrected.list))

ad.scores.df$methods <- factor(ad.scores.df$methods, 
                                levels = rev(names(ad.corrected.list)))


ggplot() + geom_col(aes(x = ad.scores.df$methods, 
                        y = ad.scores.df$scores)) + 
    geom_text(aes(x = ad.scores.df$methods, 
                    y = ad.scores.df$scores/2, 
                    label = round(ad.scores.df$scores, 3)), 
                size = 3, col = 'white') + 
    coord_flip() + theme_bw() + ylab('Alignment Scores') + 
    xlab('') + ylim(0,0.85)

## -----------------------------------------------------------------------------
splsda.plsda_batch <- splsda(X = ad.PLSDA_batch, Y = ad.trt, 
                            ncomp = 3, keepX = rep(50,3))
select.plsda_batch <- selectVar(splsda.plsda_batch, comp = 1)
head(select.plsda_batch$value)

splsda.splsda_batch <- splsda(X = ad.sPLSDA_batch, Y = ad.trt, 
                            ncomp = 3, keepX = rep(50,3))
select.splsda_batch <- selectVar(splsda.splsda_batch, comp = 1)
head(select.splsda_batch$value)

length(intersect(select.plsda_batch$name, select.splsda_batch$name))

## -----------------------------------------------------------------------------
sessionInfo()

