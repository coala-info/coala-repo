# Code example from 'CaMutQC-manual' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# # the latest version is on the devel branch, but might not be the most stable version
# # BiocManager::install(version='devel')
# 
# # the most stable version is on the release branch (by default)
# BiocManager::install("CaMutQC")

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("devtools", quietly = TRUE)) {
#     install.packages("devtools")
# }
# devtools::install_github("likelet/CaMutQC")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(CaMutQC)
MAFdat <- vcfToMAF(system.file("extdata", "WES_EA_T_1_mutect2.vep.vcf", package="CaMutQC"))
MAFdat[1:5, 1:13]

## ----message=FALSE------------------------------------------------------------
vcfPath <- system.file("extdata/Multi-caller", package="CaMutQC")
multiVCFs <- vcfToMAF(vcfPath, multiVCF=TRUE)
unique(multiVCFs$Tumor_Sample_Barcode)

## ----message=FALSE------------------------------------------------------------
MAF_qual <- mutFilterQual(MAFdat, panel="Customized", VAF=0.01, VAFratio=4)
table(MAF_qual$CaTag)

## ----message=FALSE------------------------------------------------------------
MAF_sb <- mutFilterSB(MAFdat, SBscore=2)
table(MAF_sb$CaTag)

## ----message=FALSE------------------------------------------------------------
MAF_adj <- mutFilterAdj(MAFdat, maxIndelLen=40, minInterval=15)
table(MAF_adj$CaTag)

## ----message=FALSE------------------------------------------------------------
MAF_normaldp <- mutFilterNormalDP(MAFdat, dbsnpCutoff=19, nonCutoff=8)
table(MAF_normaldp$CaTag)

## ----message=FALSE------------------------------------------------------------
MAF_pon <- mutFilterPON(MAFdat, 
                        PONfile=system.file("extdata", "PON_test.txt", 
                                            package="CaMutQC"), PONformat="txt")
table(MAF_pon$CaTag)

## ----message=FALSE------------------------------------------------------------
# labels can be added
MAF_db <- mutFilterDB(MAFdat, dbSNP=TRUE, dbVAF=0.01)
table(MAF_db$CaTag)

## ----message=FALSE------------------------------------------------------------
MAF_type <- mutFilterType(MAFdat, keepType='nonsynonymous')
table(MAF_type$CaTag)
table(MAF_type$Variant_Classification[which(MAF_type$CaTag == '0')])

## ----message=FALSE------------------------------------------------------------
MAF_reg <- mutFilterReg(MAFdat, bedFilter = TRUE,
                        bedFile=system.file("extdata/bed/panel_hg19", 
                                            "FlCDx-hg19.rds", package="CaMutQC"))
table(MAF_reg$CaTag)

## ----message=FALSE------------------------------------------------------------
MAF_tech <- mutFilterTech(MAFdat, panel="Customized", tumorDP=8, minInterval=9, 
                          tagFILTER=NULL, progressbar=FALSE, 
                          PONfile=system.file("extdata", "PON_test.txt", 
                                              package="CaMutQC"), PONformat="txt")
table(MAF_tech$CaTag)

## ----message=FALSE------------------------------------------------------------
MAF_selec <- mutSelection(MAFdat, dbVAF=0.02, keepType='nonsynonymous', progressbar=FALSE)
table(MAF_selec$CaTag)

## ----message=FALSE------------------------------------------------------------
MAFCom <- mutFilterCom(MAFdat, panel="WES", report=FALSE, TMB=FALSE, progressbar=FALSE,
                       PONfile=system.file("extdata", "PON_test.txt", 
                                           package="CaMutQC"), PONformat="txt")
table(MAFCom$CaTag)

## -----------------------------------------------------------------------------
MAFCom_tmb <- mutFilterCom(MAFdat, panel="WES", assay="Customized", report=FALSE, TMB=TRUE, 
                           bedFile=system.file("extdata/bed/panel_hg38", 
                                               "Pan-cancer-hg38.rds", package="CaMutQC"), 
                           PONfile=system.file("extdata", "PON_test.txt", package="CaMutQC"), 
                           PONformat="txt", progressbar=FALSE, verbose=FALSE)

## ----message=FALSE------------------------------------------------------------
MAFCan <- mutFilterCan(MAFdat, cancerType='LAML', report=FALSE, TMB=FALSE, 
                       progressbar=FALSE, 
                       PONfile=system.file("extdata", "PON_test.txt", 
                                           package="CaMutQC"), PONformat="txt")
table(MAFCan$CaTag)

## ----message=FALSE------------------------------------------------------------
MAFRef <- mutFilterRef(MAFdat, reference="Zhu_et_al-Nat_Commun-2020-KIRP", 
                       report=FALSE, TMB=FALSE, progressbar=FALSE,
                       PONfile=system.file("extdata", "PON_test.txt", 
                                           package="CaMutQC"), PONformat="txt")
table(MAFRef$CaTag)

## ----message=FALSE------------------------------------------------------------
tmb_value <- calTMB(MAFdat, assay='Customized', 
                    bedFile=system.file("extdata/bed/panel_hg38","Pan-cancer-hg38.rds", 
                                        package="CaMutQC"))
tmb_value

## ----message=FALSE------------------------------------------------------------
maf_MuSE <- vcfToMAF(system.file("extdata/Multi-caller", 
                                 "WES_EA_T_1.MuSE.vep.vcf", package="CaMutQC")) 
maf_MuSE_f <- mutFilterCom(maf_MuSE, report=FALSE, TMB=FALSE, 
                           PONfile=system.file("extdata", 
                                               "PON_test.txt", package="CaMutQC"), 
                           PONformat = "txt", progressbar=FALSE)
maf_VarScan2 <- vcfToMAF(system.file("extdata/Multi-caller", 
                                     "WES_EA_T_1_varscan_filter_snp.vep.vcf", package="CaMutQC"))
maf_VarScan2_f <- mutFilterCom(maf_VarScan2, report=FALSE, TMB=FALSE, 
                               PONfile=system.file("extdata", 
                                                   "PON_test.txt", package="CaMutQC"), 
                               PONformat="txt", progressbar=FALSE)
MAFdat_f <- mutFilterCom(MAFdat, report=FALSE, TMB=FALSE, 
                         PONfile=system.file("extdata", "PON_test.txt", package= "CaMutQC"), 
                         PONformat="txt", progressbar=FALSE)
mafs <- list(maf_MuSE_f, maf_VarScan2_f, MAFdat_f)
maf_union <- processMut(mafs, processMethod = "union")
maf_union

## -----------------------------------------------------------------------------
sessionInfo()

