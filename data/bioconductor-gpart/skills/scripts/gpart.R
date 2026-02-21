# Code example from 'gpart' vignette. See references/ for full tutorial.

## ----library, eval=FALSE-------------------------------------------------
#  library(gpart)

## ----library0, include=FALSE---------------------------------------------
library(gpart)

## ----data_read, echo=TRUE------------------------------------------------
data(geno)
data(SNPinfo)

## ----datatype_geno, echo=TRUE--------------------------------------------
geno[1:5, 1:5]

## ----datatype_SNPinfo, echo=TRUE-----------------------------------------
head(SNPinfo)

## ----CLQDeg1-------------------------------------------------------------
clq1 = CLQD(geno[, 1:300], SNPinfo[1:300,])


## ----CLQDeg1_2-----------------------------------------------------------
# CLQ results for 300 SNPs
head(clq1, n = 20)
table(clq1)
# n of singletons
sum(is.na(clq1))

## ----CLQDeg2, eval=FALSE-------------------------------------------------
#  CLQD(geno[, 1:500], SNPinfo[1:500,], LD = "Dprime")

## ----CLQDeg3, eval=FALSE-------------------------------------------------
#  CLQD(geno[, 1:500], SNPinfo[1:500,], CLQcut = 0.7, hrstType = "fast",
#       CLQmode = "maximal")
#  

## ----BigLDeg1------------------------------------------------------------
# Use the options `geno` and `SNPinfo` to input additive genotype data and SNP information data respectively.
# use r2 measure (default)
res1 = BigLD(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,]) 

## ----BigLDeg1-1, eval=FALSE----------------------------------------------
#  #use D' measure
#  res1_dp = BigLD(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,]
#                  ,LD = "Dprime")

## ----BigLDeg1show--------------------------------------------------------
head(res1)

## ----BigLDeg2, eval=FALSE------------------------------------------------
#  # When you have to input files directly, use the parameter `genofile` (and `SNPinfofile`) instead of `geno` and `SNPinfo`.
#  res2 = BigLD(genofile = "geno.vcf")
#  res3 = BigLD(genofile = "geno.ped", SNPinfofile = "geno.map")
#  # change LD measure, hrstParam
#  res4 = BigLD(geno = geno, SNPinfo = SNPinfo, LD = "Dprime", hrstParam = 150)

## ----BigLDeg3, eval=FALSE------------------------------------------------
#  res5 = BigLD(geno = geno, SNPinfo = SNPinfo, MAFcut = 0.1, appendRare = TRUE)

## ----BigLDeg4, eval=FALSE------------------------------------------------
#  cutlist = rbind(c(21, "rs440600", 16051956), c(21, "rs9979041", 16055738))
#  res6 = BigLD(geno = geno[, 1:100], SNPinfo = SNPinfo[1:100,], cutByForce = cutlist)

## ----BigLDeg4-1, include=FALSE-------------------------------------------
cutlist = rbind(c(21, "rs440600", 16051956), c(21, "rs9979041", 16055738))
res6 = BigLD(geno = geno[, 1:100], SNPinfo = SNPinfo[1:100,], cutByForce = cutlist)

## ----BigLDeg4show--------------------------------------------------------
print(cutlist)
head(res6)

## ----BigLDeg7, eval=FALSE------------------------------------------------
#  res7 = BigLD(geno = geno, SNPinfo = SNPinfo, startbp = 16058400, endbp = 16076500)

## ----BigLDeg7-1, include=FALSE-------------------------------------------
res7 = BigLD(geno = geno, SNPinfo = SNPinfo, startbp = 16058400, endbp = 16076500)

## ----BigLDeg7show--------------------------------------------------------
res7

## ----data_read_gene, echo=TRUE-------------------------------------------
data(geneinfo)
head(geneinfo)

## ----GPARTeg0------------------------------------------------------------
# gene based GPART using the pre-calculated BigLD result 'res1'
# The input data of GPART must be the same as the input data used to obtain 'res1'
# note that the `res1` is obtained by using the first 1000 SNPs in geno.
# default minsize = 4, maxsize = 50
Gres0 = GPART(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,], 
              geneinfo = geneinfo,BigLDresult = res1, 
              minsize = 4, maxsize = 50)

## ----GPARTeg0res---------------------------------------------------------
# results of gene-based GPART
head(Gres0)

## ----GPARTeg, eval=FALSE-------------------------------------------------
#  # gene based model
#  Gres1 = GPART(geno = geno, SNPinfo = SNPinfo, geneinfo = geneinfo)
#  # gene based model using LD measure Dprime
#  Gres2 = GPART(geno = geno, SNPinfo = SNPinfo, geneinfo = geneinfo, LD = "Dprime")

## ----GPARTeg2, eval=FALSE------------------------------------------------
#  # LD block based - use only LD block information
#  Gres3 = GPART(geno = geno, SNPinfo = SNPinfo, geneinfo = geneinfo,
#                GPARTmode = "LDblockBased", Blockbasedmode = "onlyBlocks")
#  # LD block based - use gene information to merge singletons
#  Gres4 = GPART(geno = geno, SNPinfo = SNPinfo, geneinfo = geneinfo,
#                GPARTmode = "LDblockBased", Blockbasedmode = "useGeneRegions")

## ----GPARTeg3, eval = FALSE----------------------------------------------
#  # you can load text file containing gene information.
#  Gres5 = GPART(geno = geno, SNPinfo = SNPinfo, geneinfofile = "geneinfo.txt")

## ----GPARTeg4, eval=FALSE------------------------------------------------
#  # use `geneDB` option instead of `geneinfo` or `geneinfofile`
#  # default geneDB is "ensembl" and  default assembly is "GRCh38"
#  Gres6 = GPART(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
#                BigLDresult = res1, geneDB = "ensembl", assembly = "GRCh37")
#  Gres7 = GPART(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
#                BigLDresult = res1, geneDB = "ucsc", assembly = "GRCh37" )

## ----LDheat1-0, eval=FALSE-----------------------------------------------
#  # First LDblockHeatmap calculate the LD block results using BigLD(), and then draw the LD heatmap, block boundaries and physical locations, and gene information
#  LDblockHeatmap(geno = geno, SNPinfo = SNPinfo,geneinfo = geneinfo,
#                  filename = "heatmap_all", res = 150)

## ---- out.width = "1200px", echo = FALSE---------------------------------
knitr::include_graphics("heatmap_all.png")

## ----LDheat1-1, eval=FALSE-----------------------------------------------
#  # You can use the already obtained BigLD result using an option 'blockresult'.
#  # note that the `res1` is obtained by using the first 1000 SNPs in geno.
#  LDblockHeatmap(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
#                 geneinfo = geneinfo, blockresult = res1,
#                 filename = "heatmap1", res = 200)
#  # For the obtained result 'res1', you can plot the only part of the result.
#  LDblockHeatmap(geno = geno[,300:800], SNPinfo = SNPinfo[300:800,],
#                 geneinfo = geneinfo, blockresult = res1,
#                 filename = "heatmap1_part", res = 200)
#  # If there is no inputted Big-LD result,
#  # the function will calculate the BigLD result first and then draw the figure using the result.
#  LDblockHeatmap(geno = geno, SNPinfo = SNPinfo,
#                 geneinfo = geneinfo, filename = "heatmap2")
#  # you can save the output in tiff file
#  LDblockHeatmap(geno = geno, SNPinfo = SNPinfo,
#                 geneinfo = geneinfo, filename = "heatmap3", type = "tif")

## ----LDheat2, eval=FALSE-------------------------------------------------
#  # the function first execute BigLD to obtain LDblock results, and then run GPART algorithm.
#  LDblockHeatmap(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
#                 geneinfo = geneinfo, LD = "Dprime",
#                 filename = "heatmap_Dp", res = 200)
#  # or you can use the Big-LD results already obtained.
#  LDblockHeatmap(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
#                 geneinfo = geneinfo, LD = "Dp-str"
#                 , filename = "heatmap_Dp-str", res = 200)

## ---- out.width = "1000px", echo = FALSE---------------------------------
knitr::include_graphics("heatmap_Dp-str.png")

## ----LDheat3, eval=FALSE-------------------------------------------------
#  # the function first execute BigLD to obtain LDblock results, and then run GPART algorithm.
#  LDblockHeatmap(geno = geno, SNPinfo = SNPinfo, geneinfo = geneinfo,
#                 chrN = 21, startbp = 16000000, endbp = 16200000,
#                 filename = "heatmap_16mb-16.2mb")

## ----LDheat4, eval=FALSE-------------------------------------------------
#  # using the obatined GPART results, draw figure.
#  LDblockHeatmap(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
#                 geneinfo = geneinfo, blockresult = Gres0,
#                 blocktype = "gpart", filename = "heatmap_gpart")
#  # or if you set the blocktype only, the function will execute the proper block construction algorithm.
#  LDblockHeatmap(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
#                 geneinfo = geneinfo, blocktype = "gpart",
#                 filename = "heatmap_gpart2")

## ----LDheat5, eval=FALSE-------------------------------------------------
#  # Show gene region information obtained from "ensembl" DB in assembly GRCh38.
#  LDblockHeatmap(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
#                 geneDB = "ensembl", assembly = "GRCh37",
#                 filename = "heatmap_enb")

## ----LDheat5-1, eval=FALSE-----------------------------------------------
#  # Do not show the gene region information.
#  LDblockHeatmap(geno = geno[,1:1000], SNPinfo = SNPinfo[1:1000,],
#                 geneshow = FALSE, filename = "heatmap_wogene")

## ----LDheat6, results='hide'---------------------------------------------
# using CLQshow = TRUE options to show LD bin results.
LDblockHeatmap(geno = geno, SNPinfo = SNPinfo, geneinfo = geneinfo, 
               CLQshow = TRUE, startbp = 16300000, endbp = 16350000, 
               res=200, filename = "heatmap_clq")

## ---- out.width = "1000px", echo = FALSE---------------------------------
knitr::include_graphics("heatmap_clq.png")

## ----LDheat7, eval=FALSE-------------------------------------------------
#  # using "onlyHeatmap = TRUE"
#  LDblockHeatmap(geno = geno, SNPinfo = SNPinfo, geneinfo = geneinfo,
#                 onlyHeatmap = TRUE, filename = "heatmap_no_bound", res = 150)

## ----convert2GRange------------------------------------------------------
BigLD_grange = convert2GRange(res1)
BigLD_grange

