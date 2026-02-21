# Code example from 'dyebias-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'dyebias-vignette.Rnw'

###################################################
### code chunk number 1: dyebias-vignette.Rnw:206-207
###################################################
options(continue='   ')


###################################################
### code chunk number 2: dyebias-vignette.Rnw:210-216
###################################################
  library(marray)
  library(dyebias)
  library(dyebiasexamples)
  library(convert)

  options(stringsAsFactors = FALSE)


###################################################
### code chunk number 3: dyebias-vignette.Rnw:223-225
###################################################
  datadir <- system.file("extradata", package="dyebiasexamples")
  datadir


###################################################
### code chunk number 4: dyebias-vignette.Rnw:231-238
###################################################

  sample.file <-  file.path(datadir, "Tuteja-samples.txt")

  targets <- read.marrayInfo(sample.file)

  summary(targets)



###################################################
### code chunk number 5: dyebias-vignette.Rnw:247-254
###################################################

  layout <- read.marrayLayout(fname=NULL, ngr=12, ngc=4, nsr=22, nsc=19)

  n.spots <- maNspots(layout)

  summary(layout)



###################################################
### code chunk number 6: dyebias-vignette.Rnw:264-281
###################################################

  first.file <- file.path(datadir, maInfo(targets)$filename[1])
  first.file
  gnames <- read.marrayInfo(first.file, info.id=c(7,8,10), labels=10, skip=0)
  names(maInfo(gnames)) <- c("control.type", "reporter.group", "reporterId")

  maInfo(gnames)$reporterId <- as.character(maInfo(gnames)$reporterId)

  #### Following is not really needed (it makes  the 
  ### ``"Controls are generated from an arbitaray columns\n"'' message go way

  controls <- maInfo(gnames)$reporter.group
  controls [ controls == "Experimental"] <-  "gene"
  maControls(layout) <- as.factor(controls)

  summary(gnames)



###################################################
### code chunk number 7: dyebias-vignette.Rnw:292-305
###################################################

  data.raw <- read.GenePix(fnames = maInfo(targets)$filename,
                           path = datadir,
                           name.Gf = "GenePix:F532 Median",
                           name.Gb ="GenePix:B532 Median",
                           name.Rf = "GenePix:F635 Median",
                           name.Rb = "GenePix:B635 Median",
                           name.W = "GenePix:Flags",
                           layout = layout,
                           gnames = gnames,
                           targets = targets,
                           skip=0, sep = "\t", quote = '"', DEBUG=TRUE)



###################################################
### code chunk number 8: dyebias-vignette.Rnw:314-322
###################################################

  maW(data.raw)[ maW(data.raw) == 0] <- 1
  maW(data.raw)[ maW(data.raw) < 0] <- 0

  maLayout(data.raw) <- layout

  summary(data.raw)



###################################################
### code chunk number 9: dyebias-vignette.Rnw:329-348
###################################################

  normalized.data.file <-  file.path(datadir, "E-MTAB-32-processed-data-1641029599.txt")
  data <- read.table(normalized.data.file, sep="\t", as.is=T, header=T, skip=1)
  names(data) <- c("reporterId", "X13685041", "X13685040" , "X13685153" ,"X13685151" ,"X13685042")
  ## get rid of overly long gene names:
  data$reporterId <- sub(pattern="ebi.ac.uk:MIAMExpress:Reporter:A-MEXP-1165\\.(P[0-9]+) .*",
     replacement="\\1", x=data$reporterId, perl=T, fixed=F)
  data$reporterId <- sub(pattern="ebi.ac.uk:MIAMExpress:Reporter:A-MEXP-1165\\.Blank.*",
     replacement="Blank", x=data$reporterId, perl=T, fixed=F)

  data.norm <- as(data.raw,"marrayNorm")

  ## now replace the actual data:
  m <- as.matrix(data[,c(2:6)])
  n <- as.numeric(m)
  dim(n) <- dim(m)

  maM(data.norm) <- n



###################################################
### code chunk number 10: dyebias-vignette.Rnw:368-371
###################################################

  maM(data.norm)[,c(3,4)] <- -1 *maM(data.norm)[,c(3,4)]



###################################################
### code chunk number 11: dyebias-vignette.Rnw:377-380
###################################################

  maA(data.norm) <- log2(  maRf(data.raw) * maGf(data.raw) ) / 2



###################################################
### code chunk number 12: dyebias-vignette.Rnw:404-412
###################################################

  iGSDBs.estimated <- dyebias.estimate.iGSDBs(data.norm,
                                              is.balanced=FALSE,
                                              reference="input",
                                              verbose=TRUE) 
   
  summary(iGSDBs.estimated)



###################################################
### code chunk number 13: dyebias-vignette.Rnw:425-428
###################################################

  hist(iGSDBs.estimated$dyebias, breaks=50)



###################################################
### code chunk number 14: dyebias-vignette.Rnw:447-452
###################################################

  estimator.subset <- (maInfo(maGnames(data.norm))$reporter.group=="Experimental")

  summary(estimator.subset)



###################################################
### code chunk number 15: dyebias-vignette.Rnw:474-484
###################################################

  application.subset <- ((maW(data.norm)==1)
                         & dyebias.application.subset(data.raw=data.raw,
                                min.SNR=1.5,
                                maxA=15,
                                use.background=TRUE)
                         )

  summary(as.vector(application.subset))



###################################################
### code chunk number 16: dyebias-vignette.Rnw:489-495
###################################################

  correction <- dyebias.apply.correction(data.norm=data.norm,
                                         iGSDBs=iGSDBs.estimated,
                                         estimator.subset=estimator.subset,
                                         application.subset=application.subset,
                                         verbose=TRUE)


###################################################
### code chunk number 17: dyebias-vignette.Rnw:507-509
###################################################
  correction$summary[,c("slide", "avg.correction", "var.ratio", "reduction.perc", "p.value")]



###################################################
### code chunk number 18: dyebias-vignette.Rnw:543-566
###################################################

  layout(matrix(1:2, nrow=1,ncol=2))

  dyebias.rgplot(data=data.norm,
                 slide=3,
                 iGSDBs=iGSDBs.estimated,
                 application.subset=application.subset, 
                 main="uncorrected",
                 cex=0.2,
                 cex.lab=0.8,
                 cex.main=0.8,
                 output=NULL)

  dyebias.rgplot(data=correction$data.corrected,
                 slide=3,
                 iGSDBs=iGSDBs.estimated,
                 application.subset=application.subset,
                 main="corrected",
                 cex=0.2,
                 cex.lab=0.8,
                 cex.main=0.8,
                 output=NULL)



###################################################
### code chunk number 19: dyebias-vignette.Rnw:584-611
###################################################

  layout(matrix(1:2, nrow=1,ncol=2))

  order <- dyebias.boxplot(data=data.norm, 
    iGSDBs=iGSDBs.estimated,
    order=NULL,
    ylim=c(-1,1),
    application.subset=application.subset,
    main="uncorrected",
    cex=0.2,
    cex.lab=0.8,
    cex.main=0.8,
    output=NULL
    )

  order <- dyebias.boxplot(data=correction$data.corrected, 
    iGSDBs=iGSDBs.estimated,
    order=order,
    ylim=c(-1,1),
    application.subset=application.subset, 
    main="corrected",
    cex=0.2,
    cex.lab=0.8,
    cex.main=0.8,
    output=NULL
    )



###################################################
### code chunk number 20: dyebias-vignette.Rnw:660-698 (eval = FALSE)
###################################################
## 
##   library(GEOquery)
##   library(marray)
##   library(limma)
##   library(dyebias)
##   library(dyebiasexamples)
## 
##   options(stringsAsFactors = FALSE)
## 
## 
##   gse.id <- "GSE9318"
##   ## dir <- system.file("data", package = "dyebias")
##   dir <- getwd()
## 
##   if (! file.exists(dir)) {
##     stop(sprintf("could not find directory '%s' (to write GSE9318 data to/from)", dir))
##   }
## 
##   file.RData <- sprintf("%s/%s.RData", dir,gse.id) 
## 
##   if( file.exists(file.RData) ) {
##     cat(sprintf("Loading existing data from %s\n", file.RData))
##     load(file.RData)
##   } else {
##     if ( interactive()) { 
##       if (readline(prompt=sprintf("Could not find file %s.\nDo you want me to download the data from GEO?\nThis will take a while [y/N]: ", file.RData)) != "y"  ) {
##         stop("Exiting")
##       }
##     }
##     cat("Downloading .soft file from GEO ...\n")
##     file.soft <- getGEOfile(gse.id, destdir=dir, amount="full")
##     cat("done\nParsing .soft file ...\n")
##     gse <- getGEO(filename=file.soft)
##     cat(sprintf("done\nSaving to %s ... ", file.RData))
##     save.image(file.RData)
##     cat("done\n")
##   } 
## 


###################################################
### code chunk number 21: dyebias-vignette.Rnw:727-778 (eval = FALSE)
###################################################
## 
##   ## following slides are used to obtain iGSDB estimates:
##   slide.ids.est <- c( "GSM237352", "GSM237353", "GSM237354", "GSM237355" )
## 
##   ## column names:
##   cy3.name <- "label_ch1"
##   cy5.name <- "label_ch2" 
## 
##   ## function to recognize 'genes':
##   gene.selector <- function(table){grep("^A_75_", as.character(table[["ProbeName"]]))}
## 
##   reporterid.name <- "ProbeName"
##   M.name <- "VALUE"              #normalized
##   Gf.name <- "Cy3"               #raw
##   Gb.name <- "Cy3_Background"
##   Rf.name <- "Cy5"               #raw
##   Rb.name <- "Cy3_Background"    # yes! (error in the data: Cy5_Background == Cy5 ...)
## 
##   ## convert the raw data ...
##   data.raw.est <-
##     dyebias.geo2marray(gse=gse,
##                        slide.ids=slide.ids.est,
##                        type="raw",
##                        gene.selector=gene.selector,
##                        reporterid.name=reporterid.name,
##                        cy3.name=cy3.name,
##                        cy5.name=cy5.name,
##                        Rf.name=Rf.name,
##                        Gf.name=Gf.name,
##                        Rb.name=Rb.name,
##                        Gb.name=Gb.name,
##                        )
## 
##   ## ... and the normalized data:
##   data.norm.est <-
##     dyebias.geo2marray(gse=gse,
##                        slide.ids=slide.ids.est,
##                        type="norm",
##                        gene.selector=gene.selector,
##                        reporterid.name=reporterid.name,
##                        cy3.name=cy3.name,
##                        cy5.name=cy5.name,
##                        M.name=M.name
##                        )
## 
##   ## maA was not set; do that here:
##   maA(data.norm.est) <- log2(  maRf(data.raw.est) * maGf(data.raw.est) ) / 2
## 
##   ## unswap the swapped dye-swaps:
##   maM(data.norm.est)[, c(2,4)] <-  - maM(data.norm.est)[, c(2,4)]
## 


###################################################
### code chunk number 22: dyebias-vignette.Rnw:784-787 (eval = FALSE)
###################################################
## 
##   maInfo(maTargets(data.norm.est))
## 


###################################################
### code chunk number 23: dyebias-vignette.Rnw:797-812 (eval = FALSE)
###################################################
## 
##   info <- maInfo(maTargets(data.norm.est)) 
## 
##   info$Cy3 <- c("wt",    "wt IP",  "td",    "td IP" )
##   info$Cy5 <- c("wt IP", "wt",     "td IP", "td")
## 
##   maInfo(maTargets(data.norm.est)) <- info
## 
##   references <- c("wt", "td")
## 
##    ### The estimation would then be run as:
##    ###
##    ###   iGSDBs.estimated <- dyebias.estimate.iGSDBs(data.norm.est, is.balanced=FALSE, 
##    ###                                             reference=references, verbose=TRUE)
## 


###################################################
### code chunk number 24: dyebias-vignette.Rnw:828-832 (eval = FALSE)
###################################################
## 
##   iGSDBs.estimated <- dyebias.estimate.iGSDBs(data.norm.est, is.balanced=TRUE, verbose=TRUE)
##   summary(iGSDBs.estimated)
## 


###################################################
### code chunk number 25: dyebias-vignette.Rnw:842-876 (eval = FALSE)
###################################################
## 
##   subset  <- sapply(GSMList(gse), function(x){Meta(x)$platform_id}) == "GPL5991"
##   slide.ids.all <- sapply(GSMList(gse), function(x){Meta(x)$geo_accession})[subset]
## 
##   data.raw.all <-
##     dyebias.geo2marray(gse=gse,
##                        slide.ids=slide.ids.all,
##                        type="raw",
##                        gene.selector=gene.selector,
##                        reporterid.name=reporterid.name,
##                        cy3.name=cy3.name,
##                        cy5.name=cy5.name,
##                        Rf.name=Rf.name,
##                        Gf.name=Gf.name,
##                        Rb.name=Rb.name,
##                        Gb.name=Gb.name,
##                      )
## 
##   data.norm.all <-
##     dyebias.geo2marray(gse=gse,
##                        slide.ids=slide.ids.all,
##                        type="norm",
##                        gene.selector=gene.selector,
##                        reporterid.name=reporterid.name,
##                        cy3.name=cy3.name,
##                        cy5.name=cy5.name,
##                        M.name=M.name
##                        )      
## 
##   maA(data.norm.all) <- log2(  maRf(data.raw.all) * maGf(data.raw.all) ) / 2
## 
##   swap <- c(1,2,3,5, 7,8,9) 
##   maM(data.norm.all)[, swap] <-  - maM(data.norm.all)[, swap]
## 


###################################################
### code chunk number 26: dyebias-vignette.Rnw:889-905 (eval = FALSE)
###################################################
## 
##   application.subset <- ( (maW(data.norm.all) == 1) &
##                          dyebias.application.subset(data.raw=data.raw.all,
##                                                     min.SNR=1.5,
##                                                     maxA=15,
##                                                     use.background=TRUE)
##                          )
## 
##   correction <- dyebias.apply.correction(data.norm=data.norm.all,
##                                              iGSDBs=iGSDBs.estimated,
##                                              estimator.subset=T,
##                                              application.subset=application.subset,
##                                              verbose=FALSE)
## 
##   correction$summary[,c("slide", "avg.correction", "var.ratio", "reduction.perc", "p.value")]
## 


###################################################
### code chunk number 27: dyebias-vignette.Rnw:921-942 (eval = FALSE)
###################################################
##   layout(matrix(1:2, nrow=1,ncol=2))
## 
##   dyebias.maplot(data=data.norm.all,
##                  slide=6,
##                  iGSDBs=iGSDBs.estimated,
##                  application.subset=application.subset,
##                  main="uncorrected",
##                  cex=0.2,
##                  cex.lab=0.8,
##                  cex.main=0.8,
##                  output=NULL)
## 
##   dyebias.maplot(data=correction$data.corrected,
##                  slide=6,
##                  iGSDBs=iGSDBs.estimated,
##                  application.subset=application.subset,
##                  main="corrected",
##                  cex=0.2,
##                  cex.lab=0.8,
##                  cex.main=0.8,
##                  output=NULL)


###################################################
### code chunk number 28: dyebias-vignette.Rnw:974-995 (eval = FALSE)
###################################################
## 
##   layout(matrix(1:2, nrow=1,ncol=2))
## 
##   order <- dyebias.trendplot(data=data.norm.all, 
##     iGSDBs=iGSDBs.estimated,
##     application.subset=application.subset,
##     order=NULL,
##     lwd=0.1,
##     ylim=c(-0.5,0.5),
##     output=NULL,
##     main="uncorrected")
## 
##   order <- dyebias.trendplot(data=correction$data.corrected, 
##     iGSDBs=iGSDBs.estimated,
##     application.subset=application.subset, 
##     order=order,
##     lwd=0.1,
##     ylim=c(-0.5,0.5),
##     output=NULL,
##     main="corrected")
## 


###################################################
### code chunk number 29: dyebias-vignette.Rnw:1044-1045
###################################################
  toLatex(sessionInfo())


