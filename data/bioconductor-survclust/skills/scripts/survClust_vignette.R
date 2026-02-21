# Code example from 'survClust_vignette' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----echo=TRUE, eval=FALSE----------------------------------------------------
# 
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("survClust")

## -----------------------------------------------------------------------------
library(survClust)
library(survival)
library(BiocParallel)

#mutation data
uvm_dat[[1]][1:5,1:5]

#copy number data
uvm_dat[[2]][1:5,1:5]

#TCGA UVM clinical data
head(uvm_survdat)


## ----echo=TRUE, eval=TRUE-----------------------------------------------------

cv_rounds = 10

#function to do cross validation 
uvm_all_cvrounds<-function(kk){
    this.fold<-3
    fit<-list()
    for (i in seq_len(cv_rounds)){
        fit[[i]] <- cv_survclust(uvm_dat,uvm_survdat,kk,this.fold)
        print(paste0("finished ", i, " rounds for k= ", kk))
    }
    return(fit)
}


## ----echo=TRUE, eval=FALSE----------------------------------------------------
# ptm <- Sys.time()
# cv.fit<-bplapply(2:7, uvm_all_cvrounds)
# ptm2 <- Sys.time()
# 
# #> ptm
# #[1] "2022-09-05 20:54:21 EDT"
# #> ptm2
# #[1] "2022-09-05 21:01:12 EDT"
# 
# 

## -----------------------------------------------------------------------------
lapply(uvm_dat, function(x) dim(x))

## -----------------------------------------------------------------------------

#for k=2, 1st round of cross validation
names(uvm_survClust_cv.fit[[1]][[1]])


## ----fig.width=8, fig.height=8, fig.cap= "survClust analysis of TCGA UVM mutation and Copy Number data"----

ss_stats <- getStats(uvm_survClust_cv.fit, kk=7, cvr=10)
plotStats(ss_stats, 2:7)

## ----message=FALSE, fig.cap= "survClust KM analysis for integrated TCGA UVM Mutation and Copy Number for k=4"----

k4 <- cv_voting(uvm_survClust_cv.fit, getDist(uvm_dat, uvm_survdat), pick_k=4)
table(k4)

plot(survfit(Surv(uvm_survdat[,1], uvm_survdat[,2])~k4), mark.time=TRUE, col=1:4)

## -----------------------------------------------------------------------------

mut_k4_test <- apply(uvm_dat[[1]],2,function(x) fisher.test(x,k4)$p.value)
head(sort(p.adjust(mut_k4_test)))

## ----echo = FALSE, fig.cap="TCGA UVM mutation features for k=4"---------------
htmltools::img(src = knitr::image_uri("uvm_mut_example.png"), 
               style = 'margin-left: auto;margin-right: auto')

## ----fig.width=5, fig.height=6, fig.cap= "TCGA UVM Copy Number k=4"-----------

cn_imagedata <- uvm_dat[[2]]
cn_imagedata[cn_imagedata < -1.5] <- -1.5
cn_imagedata[cn_imagedata > 1.5] <- 1.5

oo <- order(k4)
cn_imagedata <- cn_imagedata[oo,]
cn_imagedata <- cn_imagedata[,ncol(cn_imagedata):1]
#image(cn_imagedata,col=gplots::bluered(50),axes=F)

#image y labels - chr names
cnames <- colnames(cn_imagedata)
cnames <- unlist(lapply(strsplit(cnames, "\\."), function(x) x[1]))
tt <- table(cnames)
nn <- paste0("chr",1:22)

chr.labels <- rep(NA, length(cnames))

index <- 1
chr.labels[1] <- "1"

for(i in seq_len(length(nn)-1)) {
    index <- index + tt[nn[i]]
    chr.labels[index] <- gsub("chr","",nn[i+1])
}

idx <- which(!(is.na(chr.labels)))

image(cn_imagedata,col=gplots::bluered(50),axes=FALSE)

axis(2, at = 1 - (idx/length(cnames)), labels = chr.labels[idx], las=1, cex.axis=0.8)
abline(v = c(cumsum(prop.table(table(k4)))))
abline(h=c(0,1))

## -----------------------------------------------------------------------------

#function to do cross validation 
sim_cvrounds<-function(kk){
    this.fold<-3
    fit<-list()
    for (i in seq_len(cv_rounds)){
        fit[[i]] <- cv_survclust(simdat, simsurvdat,kk,this.fold)
        print(paste0("finished ", i, " rounds for k= ", kk))
    }
    return(fit)
}


ptm <- Sys.time()
sim_cv.fit<-bplapply(2:7, sim_cvrounds)
ptm2 <- Sys.time()

ptm
ptm2

## ----fig.width=8, fig.height=8, fig.cap= "survClust analysis of simulated dataset"----

ss_stats <- getStats(sim_cv.fit, kk=7, cvr=10)
plotStats(ss_stats, 2:7)

## ----message=FALSE, fig.cap= "survClust k=3 class labels KM analysis for simulated dataset "----

k3 <- cv_voting(sim_cv.fit, getDist(simdat, simsurvdat), pick_k=3)

sim_class_labels <- c(rep(1, 50), rep(2,50), rep(3,50))

table(k3, sim_class_labels)

plot(survfit(Surv(simsurvdat[,1], simsurvdat[,2]) ~ k3), mark.time=TRUE, col=1:3)

## -----------------------------------------------------------------------------

#function to do cross validation 
cvrounds_mut <- function(kk){
    this.fold<-3
    fit<-list()
    for (i in seq_len(cv_rounds)){
        fit[[i]] <- cv_survclust(uvm_mut_dat, uvm_survdat,kk,this.fold, type="mut")
        print(paste0("finished ", i, " rounds for k= ", kk))
    }
    return(fit)
}

#let's create a list object with just the mutation data 
uvm_mut_dat <- list()
uvm_mut_dat[[1]] <- uvm_dat[[1]]

ptm <- Sys.time()
uvm_mut_cv.fit<-bplapply(2:7, cvrounds_mut)
ptm2 <- Sys.time()



## ----fig.width=8, fig.height=8, fig.cap= "survClust analysis of TCGA UVM mutation data alone"----

ss_stats <- getStats(uvm_mut_cv.fit, kk=7, cvr=10)
plotStats(ss_stats, 2:7)

## ----fig.width=4, fig.height=4, message=FALSE, fig.cap= "survClust k=3 class labels KM analysis for TCGA UVM mutation data alone"----

k4 <- cv_voting(uvm_mut_cv.fit, getDist(uvm_mut_dat, uvm_survdat), pick_k=4)
plot(survfit(Surv(uvm_survdat[,1], uvm_survdat[,2]) ~ k4), mark.time=TRUE, col=2:5)

## -----------------------------------------------------------------------------

mut_k4_test <- apply(uvm_mut_dat[[1]],2,function(x) fisher.test(x,k4)$p.value)
head(sort(p.adjust(mut_k4_test)))

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# 
# # DO NOT RUN. Use provided dataset
# #Process mutation maf data
# #Download data from - https://gdc.cancer.gov/about-data/publications/pancanatlas
# 
# maf <- data.table::fread("mc3.v0.2.8.PUBLIC.maf.gz", header = TRUE)
# maf_filter <- maf %>% filter(FILTER == "PASS",
#                             Variant_Classification != "Silent")
# 
# # few lines of code in tidyR to convert maf to a binary file
# maf_binary <- maf_filter %>%
#     select(Tumor_Sample_Barcode, Hugo_Symbol) %>%
#     distinct() %>%
#     pivot_wider(names_from = "Hugo_Symbol",
#                 values_from = 'Hugo_Symbol',
#                 values_fill = 0, values_fn = function(x) 1)
# 
# maf_binary$tcga_short <- substr(maf_binary$Tumor_Sample_Barcode, 1, 12)
# 
# # Process clinical file
# tcga_clin <- readxl::read_excel("TCGA-CDR-SupplementalTableS1.xlsx", sheet=1, col_names = TRUE)
# 
# uvm_clin <- tcga_clin %>% filter(type == "UVM")
# uvm_maf_binary <- maf_binary %>%
#     filter(tcga_short %in% uvm_clin$bcr_patient_barcode) %>%
#     select(-Tumor_Sample_Barcode)
# rnames <- uvm_maf_binary$tcga_short
# 
# uvm_maf <- uvm_maf_binary %>% select(-tcga_short) %>%
#     apply(., 2, as.numeric)
# 
# # Remove singletons
# gene_sum <- apply(uvm_maf,2,sum)
# idx <- which(gene_sum > 1)
# 
# uvm_maf <- uvm_maf[,idx]
# rownames(uvm_maf) <- rnames
# 
# 
# uvm_survdat <- uvm_clin %>% select(OS.time, OS) %>%
#     apply(., 2, as.numeric)
# 
# rownames(uvm_survdat) <- uvm_clin$bcr_patient_barcode
# 
# # process CN
# library(cluster)#pam function for derive medoid
# library(GenomicRanges) #interval overlap to remove CNV
# library(iClusterPlus)
# 
# seg <- read.delim(file="broad.mit.edu_PANCAN_Genome_Wide_SNP_6_whitelisted.seg", header=TRUE,sep="\t", as.is=TRUE)
# 
# pp <- substr(seg$Sample,13,16)
# seg.idx <- c(grep("-01A",pp),grep("-01B",pp),grep("-03A",pp))
# 
# #only take tumors
# seg.idx <- c(grep("-01A",pp),grep("-01B",pp))
# seg <- seg[seg.idx,]
# 
# seg$Sample <- substr(seg[,1],1,12)
# 
# uvm_seg <- seg[seg$Sample %in% uvm_clin$bcr_patient_barcode,]
# 
# colnames(uvm_seg) <- c("Sample", "Chromosome", "Start", "End", "Num_Probes", "Segment_Mean")
# 
# # pass epsilon as 0.001 default or user
# reducedMseg <- CNregions(ss_seg,epsilon=0.001,adaptive=FALSE,rmCNV=FALSE, cnv=NULL, frac.overlap=0.5, rmSmallseg=TRUE, nProbes=75)
# 
# uvm_dat <- list(uvm_mut = uvm_maf, uvm_cn = uvm_seg)
# 

## ----echo=TRUE, eval=FALSE----------------------------------------------------
# set.seed(112)
# n1 <- 50 #class1
# n2 <- 50 #class2
# n3 <- 50 #class3
# n <- n1+n2+n3
# p <- 15 #survival related features (10%)
# q <- 120 #noise
# 
# #class1 ~ N(1.5,1), class2 ~ N(0,1), class3 ~ N(-1.5,1)
# 
# sample_names <- paste0("S",1:n)
# feature_names <- paste0("features", 1:n)
# 
# #final matrix
# x_big <- NULL
# 
# ################
# # sample 15 informant features
# 
# #simulating class1
# x1a <- matrix(rnorm(n1*p, 1.5, 1), ncol=p)
# 
# #simulating class2
# x2a <- matrix(rnorm(n2*p), ncol=p)
# 
# 
# #simulating class3
# x3a <- matrix(rnorm(n3*p, -1.5,1), ncol=p)
# 
# #this concluded that part shaded in red of the matrix -
# #corresponding to related to survival and molecularly distinct
# xa <- rbind(x1a,x2a,x3a)
# 
# ################
# # sample 15 other informant features, but scramble them.
# 
# permute.idx<-sample(1:length(sample_names),length(sample_names))
# 
# x1b <- matrix(rnorm(n1*p, 1.5, 1), ncol=p)
# x2b <- matrix(rnorm(n2*p), ncol=p)
# x3b <- matrix(rnorm(n3*p, -1.5,1), ncol=p)
# 
# #this concluded that part shaded in blue of the matrix -
# #containing the molecular distinct features but not related to survival
# xb <- rbind(x1b,x2b,x3b)
# 
# 
# #this concludes the area shaded area in grey which corresponds to noise
# xc <- matrix(rnorm(n*q), ncol=q)
# 
# x_big <- cbind(xa,xb[permute.idx,], xc)
# 
# rownames(x_big) <- sample_names
# colnames(x_big) <- feature_names
# simdat <- list()
# simdat[[1]] <- x_big
# 
# #the three classes will have a median survival of 4.5, 3.25 and 2 yrs respectively
# set.seed(112)
# med_surv_class1 <- log(2)/4.5
# med_surv_class2 <- log(2)/3.25
# med_surv_class3 <- log(2)/2
# 
# surv_dist_class1 <- rexp(n1,rate=med_surv_class1)
# censor_events_class1 <- runif(n1,0,10)
# 
# surv_dist_class2 <- rexp(n2,rate=med_surv_class2)
# censor_events_class2 <- runif(n2,0,10)
# 
# surv_dist_class3 <- rexp(n3,rate=med_surv_class3)
# censor_events_class3 <- runif(n3,0,10)
# 
# surv_time_class1 <- pmin(surv_dist_class1,censor_events_class1)
# surv_time_class2 <- pmin(surv_dist_class2,censor_events_class2)
# surv_time_class3 <- pmin(surv_dist_class3,censor_events_class3)
# 
# event <- c((surv_time_class1==surv_dist_class1),
#           (surv_time_class2==surv_dist_class2),
#           (surv_time_class3==surv_dist_class3))
# 
# time <- c(surv_time_class1, surv_time_class2, surv_time_class3)
# 
# survdat <- cbind(time, event)
# 
# simsurvdat <- cbind(time, event)
# rownames(simsurvdat) <- sample_names

## -----------------------------------------------------------------------------
sessionInfo()

