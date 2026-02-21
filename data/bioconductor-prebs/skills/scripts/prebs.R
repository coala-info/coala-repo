# Code example from 'prebs' vignette. See references/ for full tutorial.

### R code from vignette source 'prebs.Rnw'

###################################################
### code chunk number 1: prebs.Rnw:38-41 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("prebs")


###################################################
### code chunk number 2: prebs.Rnw:46-49 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("prebsdata")


###################################################
### code chunk number 3: prebs.Rnw:59-61
###################################################
library(prebs)
library(prebsdata)


###################################################
### code chunk number 4: prebs.Rnw:68-79
###################################################
bam_file1 <- system.file(file.path("sample_bam_files", "input1.bam"), 
                         package="prebsdata")
bam_file2 <- system.file(file.path("sample_bam_files", "input2.bam"), 
                         package="prebsdata")
bam_files <- c(bam_file1, bam_file2)
custom_cdf_mapping1 <- system.file(file.path("custom-cdf", 
    "HGU133Plus2_Hs_ENSG_mapping.txt"), package="prebsdata")
custom_cdf_mapping2 <- system.file(file.path("custom-cdf", 
    "HGU133A2_Hs_ENSG_mapping.txt"), package="prebsdata")
manufacturer_cdf_mapping <- system.file(file.path("manufacturer-cdf", 
    "HGU133Plus2_mapping.txt"), package="prebsdata")


###################################################
### code chunk number 5: prebs.Rnw:124-125 (eval = FALSE)
###################################################
## write.table(exprs(prebs_values), file="prebs_values.txt", quote=FALSE)


###################################################
### code chunk number 6: prebs.Rnw:187-192 (eval = FALSE)
###################################################
## library("parallel")
## N_CORES = 2
## CLUSTER <- makeCluster(N_CORES)
## prebs_values <- calc_prebs(bam_files, custom_cdf_mapping1, cluster=CLUSTER)
## stopCluster(CLUSTER)


###################################################
### code chunk number 7: prebs.Rnw:198-199 (eval = FALSE)
###################################################
## prebs_values <- calc_prebs(bam_files, custom_cdf_mapping2)


###################################################
### code chunk number 8: prebs.Rnw:208-210
###################################################
prebs_values <- calc_prebs(bam_files, manufacturer_cdf_mapping)
head(exprs(prebs_values))


###################################################
### code chunk number 9: prebs.Rnw:219-221 (eval = FALSE)
###################################################
## prebs_values <- calc_prebs(bam_files, manufacturer_cdf_mapping, 
##                            cdf_name="hgu133plus2cdf")


###################################################
### code chunk number 10: prebs.Rnw:273-276 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("hgu133plus2cdf")


###################################################
### code chunk number 11: prebs.Rnw:284-287 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("hgu133plus2probe")


###################################################
### code chunk number 12: prebs.Rnw:290-293
###################################################
library("hgu133plus2probe")
probes <- as.data.frame(hgu133plus2probe)
head(probes)


###################################################
### code chunk number 13: prebs.Rnw:298-302 (eval = FALSE)
###################################################
## library("affy")
## probes <- probes[substr(probes$Probe.Set.Name,1,4) != "AFFX",]
## probes$Probe.ID <- xy2indices(probes$x, probes$y, cdf="hgu133plus2cdf")
## write.table(probes, file="probes.txt", quote=FALSE, row.names=FALSE, col.names=TRUE)


###################################################
### code chunk number 14: prebs.Rnw:320-338 (eval = FALSE)
###################################################
## probe_mappings <- read.table("output_probe_mappings.map")
## 
## colnames(probe_mappings) <- c("Probe.ID", "strand", 
##                               "chr", "start", "seq", "match", "multiple")
## 
## # bowtie reports 0-offset, but _mapping.txt files are 1-offset
## probe_mappings$start <- probe_mappings$start + 1 
## 
## probes <- read.table("probes.txt", head=TRUE)
## 
## probes <- merge(probes, probe_mappings)
## 
## output_table <- data.frame(Probe.Set.Name=probes$Probe.Set.Name, 
##     Chr=probes$chr, Chr.Strand=probes$strand, Chr.From=probes$start, 
##     Probe.X=probes$x, Probe.Y=probes$y, Affy.Probe.Set.Name=probes$Probe.Set.Name)
## 
## write.table(output_table, file="HGU133Plus2_mapping.txt", 
##             quote=FALSE, sep="\t", row.names=FALSE)


###################################################
### code chunk number 15: sessionInfo
###################################################
sessionInfo()


