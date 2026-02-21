# Code example from 'NGScopy-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'NGScopy-vignette.Rnw'

###################################################
### code chunk number 1: NGScopy-vignette.Rnw:47-48
###################################################
  cat(as.character(packageVersion('NGScopy')))


###################################################
### code chunk number 2: NGScopy-vignette.Rnw:52-53
###################################################
  cat(unlist(strsplit(packageDescription('NGScopy')[['Date']],' '))[1])


###################################################
### code chunk number 3: NGScopy-vignette.Rnw:62-63
###################################################
  cat(length(NGScopy::parse_segmtype()))


###################################################
### code chunk number 4: NGScopy-vignette.Rnw:221-225 (eval = FALSE)
###################################################
## ## install NGScopy
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("NGScopy")


###################################################
### code chunk number 5: NGScopy-vignette.Rnw:228-230 (eval = FALSE)
###################################################
## ## install NGScopyData for example data sets used in this guide
## BiocManager::install("NGScopyData")


###################################################
### code chunk number 6: NGScopy-vignette.Rnw:244-247
###################################################
## Load R libraries
require("NGScopy")
require("NGScopyData")


###################################################
### code chunk number 7: NGScopy-vignette.Rnw:250-265
###################################################
## Create an instance of `NGScopy' class
obj <- NGScopy$new(
  outFpre="ngscopy-case1",         # specified directory for output
  inFpathN=tps_N8.chr6()$bamFpath, # normal sample: tps_90.chr6.sort.bam
  inFpathT=tps_90.chr6()$bamFpath, # tumor sample:  tps_N8.chr6.sort.bam
  libsizeN=5777087,                # the library size of the normal sample
  libsizeT=4624267,                # the library size of the tumor sample
  mindepth=20,                     # the minimal depth of reads per window
  minsize=20000,                   # the minimal size of a window
  regions=NULL,                    # the regions, set to NULL for the entire genome
  segtype="mean.cusum",            # the type of segmentation
  dsN=1,                           # the downsampling factor of the normal 
  dsT=1,                           # the downsampling factor of the tumor
  pcThreads=1                      # the number of processors for computing
  )


###################################################
### code chunk number 8: NGScopy-vignette.Rnw:268-271 (eval = FALSE)
###################################################
## ## Compute the relative CNRs and save it
## ## A data.frame will be saved to file `ngscopy_cn.txt' in the output directory
## obj$write_cn()


###################################################
### code chunk number 9: NGScopy-vignette.Rnw:274-277 (eval = FALSE)
###################################################
## ## Compute the segmentation and save it
## ## A data.frame will be saved to file `ngscopy_segm.txt' in the output directory
## obj$write_segm()


###################################################
### code chunk number 10: NGScopy-vignette.Rnw:280-283 (eval = FALSE)
###################################################
## ## Plot he relative CNRs with the segmentation
## ## Figure(s) will be saved to file `ngscopy_out.pdf' in the output directory
## obj$plot_out() 


###################################################
### code chunk number 11: NGScopy-vignette.Rnw:311-328
###################################################
require(NGScopy)
require(NGScopyData)
obj <- NGScopy$new(
  outFpre="ngscopy-case1",         # specified directory for output
  inFpathN=tps_N8.chr6()$bamFpath, # normal sample: tps_90.chr6.sort.bam
  inFpathT=tps_90.chr6()$bamFpath, # tumor sample:  tps_N8.chr6.sort.bam
  libsizeN=5777087,                # the library size of the normal sample
  libsizeT=4624267,                # the library size of the tumor sample
  mindepth=20,                     # the minimal depth of reads per window
  minsize=20000,                   # the minimal size of a window
  regions=read_regions("chr6 41000000 81000000"),
                                   # the regions, set to NULL for the entire genome
  segtype="mean.norm",             # the type of segmentation
  dsN=1,                           # the downsampling factor of the normal 
  dsT=1,                           # the downsampling factor of the tumor
  pcThreads=1                      # the number of processors for computing
  )


###################################################
### code chunk number 12: NGScopy-vignette.Rnw:331-332
###################################################
obj$show()                         # print the instance


###################################################
### code chunk number 13: NGScopy-vignette.Rnw:340-343
###################################################
## Get the input files
obj$get_inFpathN()
obj$get_inFpathT()


###################################################
### code chunk number 14: NGScopy-vignette.Rnw:346-349
###################################################
## Get the library sizes
obj$get_libsizeN()
obj$get_libsizeT()


###################################################
### code chunk number 15: NGScopy-vignette.Rnw:352-355
###################################################
## Get the windowing parameters
obj$get_mindepth()
obj$get_minsize()


###################################################
### code chunk number 16: NGScopy-vignette.Rnw:358-360
###################################################
## Get the regions
head(obj$get_regions())


###################################################
### code chunk number 17: NGScopy-vignette.Rnw:363-365
###################################################
## Get the segmentation type(s)
head(obj$get_segmtype())


###################################################
### code chunk number 18: NGScopy-vignette.Rnw:368-371
###################################################
## Get the downsampling factors
obj$get_dsN()
obj$get_dsT()


###################################################
### code chunk number 19: NGScopy-vignette.Rnw:374-376
###################################################
## Get the number of processors
obj$get_pcThreads()


###################################################
### code chunk number 20: NGScopy-vignette.Rnw:379-381
###################################################
## Get the chromosome names of the reference genome 
obj$get_refname()


###################################################
### code chunk number 21: NGScopy-vignette.Rnw:384-386
###################################################
## Get the chromosome lengths of the reference genome 
obj$get_reflength()


###################################################
### code chunk number 22: NGScopy-vignette.Rnw:394-395
###################################################
obj$proc_normal()                  # this may take a while


###################################################
### code chunk number 23: NGScopy-vignette.Rnw:402-403
###################################################
obj$proc_tumor()                   # this may take a while


###################################################
### code chunk number 24: NGScopy-vignette.Rnw:410-414 (eval = FALSE)
###################################################
## ## A data.frame will be saved to file `ngscopy_cn.txt' in the output directory
## obj$calc_cn()
## obj$proc_cn()
## obj$write_cn()


###################################################
### code chunk number 25: NGScopy-vignette.Rnw:421-425 (eval = FALSE)
###################################################
## ## A data.frame will be saved to file `ngscopy_segm.txt' in the output directory
## obj$calc_segm()
## obj$proc_segm()
## obj$write_segm() 


###################################################
### code chunk number 26: NGScopy-vignette.Rnw:432-434
###################################################
## The NGScopy output is saved as a ngscopy_out.RData file in the output directory
obj$saveme()


###################################################
### code chunk number 27: NGScopy-vignette.Rnw:443-446
###################################################
## Load the output
## (optional if the previous steps have completed in the same R session)
obj$loadme()


###################################################
### code chunk number 28: NGScopy-vignette.Rnw:449-451
###################################################
## Get the output directory
obj$get_outFpre()


###################################################
### code chunk number 29: NGScopy-vignette.Rnw:454-456
###################################################
## Get the windows
head(obj$get_windows())


###################################################
### code chunk number 30: NGScopy-vignette.Rnw:459-461
###################################################
## Get the window sizes
head(obj$get_size())


###################################################
### code chunk number 31: NGScopy-vignette.Rnw:464-466
###################################################
## Get the window positions (midpoints of the windows)
head(obj$get_pos())


###################################################
### code chunk number 32: NGScopy-vignette.Rnw:469-471
###################################################
## Get the number of reads per window in the normal
head(obj$get_depthN())


###################################################
### code chunk number 33: NGScopy-vignette.Rnw:474-476
###################################################
## Get the number of reads per window in the tumor
head(obj$get_depthT())


###################################################
### code chunk number 34: NGScopy-vignette.Rnw:479-482
###################################################
## Get the data.frame of copy number calling
data.cn <- obj$get_data.cn()
head(data.cn)


###################################################
### code chunk number 35: NGScopy-vignette.Rnw:485-487
###################################################
data.segm <- obj$get_data.segm()
head(data.segm)


###################################################
### code chunk number 36: NGScopy-vignette.Rnw:506-508
###################################################
## A figure will be saved to file `ngscopy_cn.pdf' in the output directory
obj$plot_out(ylim=c(-3,3))       # reset `ylim' to NULL to allow full-scale display


###################################################
### code chunk number 37: NGScopy-vignette.Rnw:528-543
###################################################
obj <- NGScopy$new(
  outFpre="ngscopy-case1b",        # specified directory for output
  inFpathN=tps_N8.chr6()$bamFpath, # normal sample: tps_90.chr6.sort.bam
  inFpathT=tps_90.chr6()$bamFpath, # tumor sample:  tps_N8.chr6.sort.bam
  libsizeN=5777087,                # the library size of the normal sample
  libsizeT=4624267,                # the library size of the tumor sample
  mindepth=20,                     # the minimal depth of reads per window
  minsize=20000,                   # the minimal size of a window
  regions=read_regions("chr6 0 171115067"),
                                   # the regions, set to NULL for the entire genome
  segtype="mean.norm",             # the type of segmentation
  dsN=1,                           # the downsampling factor of the normal 
  dsT=1,                           # the downsampling factor of the tumor
  pcThreads=1                      # the number of processors for computing
  )


###################################################
### code chunk number 38: NGScopy-vignette.Rnw:546-548
###################################################
## Show the regions
obj$get_regions()


###################################################
### code chunk number 39: NGScopy-vignette.Rnw:569-570
###################################################
NGScopy::parse_segmtype()


###################################################
### code chunk number 40: NGScopy-vignette.Rnw:577-578
###################################################
## NGScopy::help_segmtype("mean.norm")


###################################################
### code chunk number 41: NGScopy-vignette.Rnw:585-587
###################################################
require(NGScopy)
obj <- NGScopy$new()


###################################################
### code chunk number 42: NGScopy-vignette.Rnw:590-592
###################################################
## Set segtype with multiple values
obj$set_segmtype("mean.norm,meanvar.norm,mean.cusum,var.css")


###################################################
### code chunk number 43: NGScopy-vignette.Rnw:595-597
###################################################
## Get segtype
obj$get_segmtype()


###################################################
### code chunk number 44: NGScopy-vignette.Rnw:624-626
###################################################
require(NGScopy)
require(NGScopyData)


###################################################
### code chunk number 45: NGScopy-vignette.Rnw:629-631
###################################################
## Create an instance of `NGScopy' class
obj <- NGScopy$new(pcThreads=1)


###################################################
### code chunk number 46: NGScopy-vignette.Rnw:634-636
###################################################
## Set the normal sample
obj$set_normal(tps_N8.chr6()$bamFpath)


###################################################
### code chunk number 47: NGScopy-vignette.Rnw:639-642
###################################################
## Set the regions
regions <- read_regions("chr6 41000000 81000000")
obj$set_regions(regions)


###################################################
### code chunk number 48: NGScopy-vignette.Rnw:645-647
###################################################
## Set the library size of the normal
obj$set_libsizeN(5777087)


###################################################
### code chunk number 49: NGScopy-vignette.Rnw:650-653
###################################################
## Specify a directory for output
## It will be saved as "ngscopy_normal.RData" in this directory
obj$set_outFpre("ngscopy-case2/tps_N8")


###################################################
### code chunk number 50: NGScopy-vignette.Rnw:656-658
###################################################
## Show the input
obj$show()


###################################################
### code chunk number 51: NGScopy-vignette.Rnw:661-663
###################################################
## Make windows and count reads in the normal
obj$proc_normal()


###################################################
### code chunk number 52: NGScopy-vignette.Rnw:666-668
###################################################
## Save the output of the normal for later usage
obj$save_normal()


###################################################
### code chunk number 53: NGScopy-vignette.Rnw:678-680
###################################################
## Create an instance of `NGScopy' class
obj1 <- NGScopy$new(pcThreads=1)


###################################################
### code chunk number 54: NGScopy-vignette.Rnw:683-685
###################################################
## Load the previously saved output of the normal
obj1$load_normal("ngscopy-case2/tps_N8")


###################################################
### code chunk number 55: NGScopy-vignette.Rnw:688-691
###################################################
## Set a tumor sample (ID: tps_90) and specify a directory for output
obj1$set_tumor(tps_90.chr6()$bamFpath)
obj1$set_outFpre("ngscopy-case2/tps_90")


###################################################
### code chunk number 56: NGScopy-vignette.Rnw:694-696
###################################################
## Set the library size of the tumor
obj1$set_libsizeT(4624267)


###################################################
### code chunk number 57: NGScopy-vignette.Rnw:699-701
###################################################
## Show the input
obj1$show()


###################################################
### code chunk number 58: NGScopy-vignette.Rnw:704-706
###################################################
## Process the tumor
obj1$proc_tumor()


###################################################
### code chunk number 59: NGScopy-vignette.Rnw:709-711
###################################################
## Process the copy number
obj1$proc_cn()


###################################################
### code chunk number 60: NGScopy-vignette.Rnw:714-716
###################################################
## Process the segmentation
obj1$proc_segm()


###################################################
### code chunk number 61: NGScopy-vignette.Rnw:719-721
###################################################
## Plot
obj1$plot_out(ylim=c(-3,3))


###################################################
### code chunk number 62: NGScopy-vignette.Rnw:733-735
###################################################
## Create another instance of `NGScopy' class
obj2 <- NGScopy$new(pcThreads=1)


###################################################
### code chunk number 63: NGScopy-vignette.Rnw:738-740
###################################################
## Load the previously saved output of the normal
obj2$load_normal("ngscopy-case2/tps_N8")


###################################################
### code chunk number 64: NGScopy-vignette.Rnw:743-746
###################################################
## Set a tumor sample (ID: tps_27) and specify a directory for output
obj2$set_tumor(tps_27.chr6()$bamFpath)
obj2$set_outFpre("ngscopy-case2/tps_27")


###################################################
### code chunk number 65: NGScopy-vignette.Rnw:749-751
###################################################
## Set the library size of the tumor
obj2$set_libsizeT(10220498)


###################################################
### code chunk number 66: NGScopy-vignette.Rnw:754-756
###################################################
## Show the input
obj2$show()


###################################################
### code chunk number 67: NGScopy-vignette.Rnw:759-761
###################################################
## Process the tumor
obj2$proc_tumor()


###################################################
### code chunk number 68: NGScopy-vignette.Rnw:764-766
###################################################
## Process the copy number
obj2$proc_cn()


###################################################
### code chunk number 69: NGScopy-vignette.Rnw:769-771
###################################################
## Process the segmentation
obj2$proc_segm()


###################################################
### code chunk number 70: NGScopy-vignette.Rnw:774-776
###################################################
## Plot
obj2$plot_out(ylim=c(-3,3))


###################################################
### code chunk number 71: NGScopy-vignette.Rnw:803-805
###################################################
## Create a new instance of `NGScopy' class
obj <- NGScopy$new(pcThreads=1)


###################################################
### code chunk number 72: NGScopy-vignette.Rnw:808-810
###################################################
## Set the normal sample
obj$set_normal(tps_N8.chr6()$bamFpath)


###################################################
### code chunk number 73: NGScopy-vignette.Rnw:813-815
###################################################
## Read the regions from an external file 
regions <- Xmisc::get_extdata('NGScopy','hg19_chr6_0_171115067.txt')


###################################################
### code chunk number 74: NGScopy-vignette.Rnw:818-820
###################################################
## ## Or from a text input as we did before
## regions <- read_regions("chr6 0 171115067")


###################################################
### code chunk number 75: NGScopy-vignette.Rnw:823-825
###################################################
## Set the regions
obj$set_regions(regions)


###################################################
### code chunk number 76: NGScopy-vignette.Rnw:828-830
###################################################
## Show the regions
obj$get_regions()


###################################################
### code chunk number 77: NGScopy-vignette.Rnw:863-864
###################################################
system.file('bin', 'ngscopy', package='NGScopy', mustWork=TRUE)


###################################################
### code chunk number 78: NGScopy-vignette.Rnw:867-869
###################################################
## Or,
Xmisc::get_executable('NGScopy')


