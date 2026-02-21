# Code example from 'INTACT' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("INTACT")

## -----------------------------------------------------------------------------
library(INTACT)
data(simdat)

rst <- INTACT::intact(GLCP_vec=simdat$GLCP, 
                      z_vec=simdat$TWAS_z)

## -----------------------------------------------------------------------------
rst1 <- INTACT::intact(GLCP_vec=simdat$GLCP, 
                       prior_fun=INTACT::expit, 
                       z_vec = simdat$TWAS_z,
                       t = 0.02,D = 0.09)
rst2 <- INTACT::intact(GLCP_vec=simdat$GLCP, 
                       prior_fun=INTACT::step, 
                       z_vec = simdat$TWAS_z,
                       t = 0.49)
rst3 <- INTACT::intact(GLCP_vec=simdat$GLCP, 
                       prior_fun=INTACT::hybrid, 
                       z_vec = simdat$TWAS_z,
                       t = 0.49,D = 0.05)

## -----------------------------------------------------------------------------
fdr_example <- fdr_rst(rst1, alpha = 0.05)
head(fdr_example)

## -----------------------------------------------------------------------------
data(gene_set_list)
INTACT::intactGSE(gene_data = simdat,gene_sets = gene_set_list)

## -----------------------------------------------------------------------------
INTACT::intactGSE(gene_data = simdat,prior_fun = INTACT::step,
                  t = 0.45,gene_sets = gene_set_list)
INTACT::intactGSE(gene_data = simdat,prior_fun = INTACT::expit,
                  t = 0.08,D = 0.08, gene_sets = gene_set_list)
INTACT::intactGSE(gene_data = simdat,prior_fun = INTACT::hybrid,
                  t = 0.08,D = 0.08, gene_sets = gene_set_list)

## -----------------------------------------------------------------------------
data(z_sumstats)
data(exprwt_sumstats)
data(protwt_sumstats)
data(ld_sumstats)

INTACT::chisq_sumstat(z_vec = z_sumstats,
              w = cbind(protwt_sumstats,exprwt_sumstats),
              R = ld_sumstats)

## -----------------------------------------------------------------------------
data(multi_simdat)

rst <- INTACT::multi_intact(df = multi_simdat)

## ----echo=FALSE---------------------------------------------------------------
print(head(rst[[1]]))
print(rst[[2]])
print(rst[[3]])

## ----echo=FALSE---------------------------------------------------------------
library(ggplot2)

output <- rst[[1]]

print(ggplot(output, aes(x=GPPC)) +
        geom_histogram(binwidth=0.01) +
        ylab("Number of simulated genes") +
        theme_bw() +
        theme(text = element_text(size=10,face="bold"))) 

gprp1 <- data.frame("GPRP" = output$GPRP_1,"Gene_product" = "Expression")
gprp2 <- data.frame("GPRP" = output$GPRP_2,"Gene_product" = "Protein")
gprp <- rbind.data.frame(gprp1,gprp2)

print(ggplot(gprp,aes(x=GPRP,fill=Gene_product)) +
        geom_histogram(binwidth=0.01)+
        facet_wrap(~Gene_product) +
        ylab("Number of simulated genes") + 
        scale_fill_manual(values=c("blue","red")) +
        theme_bw() +
        theme(text = element_text(size=10,face="bold")))


## -----------------------------------------------------------------------------
rst <- INTACT::multi_intact(df = multi_simdat,return_model_posteriors = TRUE)

## ----echo=FALSE---------------------------------------------------------------
print(head(rst[[1]]))

## -----------------------------------------------------------------------------
rst <- INTACT::multi_intact(df = multi_simdat,em_algorithm = FALSE)

## ----echo=FALSE---------------------------------------------------------------
print(head(rst))

## -----------------------------------------------------------------------------
sessionInfo()

