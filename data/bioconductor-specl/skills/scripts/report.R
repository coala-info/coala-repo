# Code example from 'report' vignette. See references/ for full tutorial.

## ----library------------------------------------------------------------------
library(specL)

## ----render, eval=FALSE-------------------------------------------------------
# library(rmarkdown)
# library(BiocStyle)
# report_file <- tempfile(fileext='.Rmd');
# file.copy(system.file("doc", "report.Rmd",
#                       package = "specL"),
#           report_file);
# rmarkdown::render(report_file,
#                   output_format='html_document',
#                   output_file='/tmp/report_specL.html')

## ----defineInput--------------------------------------------------------------
if(!exists("INPUT")){
  INPUT <- list(FASTA_FILE 
      = system.file("extdata", "SP201602-specL.fasta.gz",
                    package = "specL"),
    BLIB_FILTERED_FILE 
      = system.file("extdata", "peptideStd.sqlite",
                    package = "specL"),
    BLIB_REDUNDANT_FILE 
      = system.file("extdata", "peptideStd_redundant.sqlite",
                    package = "specL"),
    MIN_IONS = 5,
    MAX_IONS = 6,
    MZ_ERROR = 0.05,
    MASCOTSCORECUTOFF = 17,
    FRAGMENTIONMZRANGE = c(300, 1250),
    FRAGMENTIONRANGE = c(5, 200),
    NORMRTPEPTIDES = specL::iRTpeptides,
    OUTPUT_LIBRARY_FILE = tempfile(fileext ='.csv'),
    RDATA_LIBRARY_FILE = tempfile(fileext ='.RData'),
    ANNOTATE = TRUE
    )
} 

## ----cat, echo=FALSE, eval=FALSE----------------------------------------------
#   cat(
#   " MASCOTSCORECUTOFF = ", INPUT$MASCOTSCORECUTOFF, "\n",
#   " BLIB_FILTERED_FILE = ", INPUT$BLIB_FILTERED_FILE, "\n",
#   " BLIB_REDUNDANT_FILE = ", INPUT$BLIB_REDUNDANT_FILE, "\n",
#   " MZ_ERROR = ", INPUT$MZ_ERROR, "\n",
#   " FRAGMENTIONMZRANGE = ", INPUT$FRAGMENTIONMZRANGE, "\n",
#   " FRAGMENTIONRANGE = ", INPUT$FRAGMENTIONRANGE, "\n",
#   " FASTA_FILE = ", INPUT$FASTA_FILE, "\n",
#   " MAX_IONS = ", INPUT$MAX_IONS, "\n",
#   " MIN_IONS = ", INPUT$MIN_IONS, "\n"
#   )
# 

## ----kableParameter, echo=FALSE, results='asis'-------------------------------
library(knitr)
# kable(t(as.data.frame(INPUT)))
ii <- ((lapply(INPUT, function(x){ if(typeof(x) %in% c("character", "double")){paste(x, collapse = ', ')}else{NULL} } )))


parameter <- as.data.frame(unlist(ii))
names(parameter) <- 'parameter.values'
kable(parameter, caption = 'used INPUT parameter')

## ----defineFragmenIons--------------------------------------------------------
fragmentIonFunction_specL <- function (b, y) {
  Hydrogen <- 1.007825
  Oxygen <- 15.994915
  Nitrogen <- 14.003074
  b1_ <- (b )
  y1_ <- (y )
  b2_ <- (b + Hydrogen) / 2
  y2_ <- (y + Hydrogen) / 2 
  return( cbind(b1_, y1_, b2_, y2_) )
}

## ----readSqliteFILTERED, warning=FALSE----------------------------------------
BLIB_FILTERED <- read.bibliospec(INPUT$BLIB_FILTERED_FILE) 

summary(BLIB_FILTERED)

## ----readSqliteREDUNDANT, warning=FALSE---------------------------------------
BLIB_REDUNDANT <- read.bibliospec(INPUT$BLIB_REDUNDANT_FILE) 
summary(BLIB_REDUNDANT)

## ----read.fasta---------------------------------------------------------------
if(INPUT$ANNOTATE){
  FASTA <- read.fasta(INPUT$FASTA_FILE, 
                    seqtype = "AA", 
                    as.string = TRUE)

  BLIB_FILTERED <- annotate.protein_id(BLIB_FILTERED, 
                                       fasta = FASTA)
}

## ----checkIRTs, echo=FALSE, results='asis'------------------------------------
library(knitr)
incl <-  INPUT$NORMRTPEPTIDES$peptide %in% sapply(BLIB_REDUNDANT, function(x){x$peptideSequence})
INPUT$NORMRTPEPTIDES$included <- incl

if (sum(incl) > 0){
  res <- INPUT$NORMRTPEPTIDES[order(INPUT$NORMRTPEPTIDES$rt),]
  # row.names(res) <- 1:nrow(res)
  kable(res, caption='peptides used for RT normaization.')
}

## ----specL::genSwathIonLib, message=FALSE-------------------------------------
specLibrary <- specL::genSwathIonLib(
  data = BLIB_FILTERED,
  data.fit = BLIB_REDUNDANT,
  max.mZ.Da.error = INPUT$MZ_ERROR,
  topN = INPUT$MAX_IONS,
  fragmentIonMzRange = INPUT$FRAGMENTIONMZRANGE,
  fragmentIonRange = INPUT$FRAGMENTIONRANGE,
  fragmentIonFUN = fragmentIonFunction_specL,
  mascotIonScoreCutOFF = INPUT$MASCOTSCORECUTOFF,
  iRT = INPUT$NORMRTPEPTIDES
  )

## ----summarySpecLibrary-------------------------------------------------------
summary(specLibrary)

## ----showSpecLibrary----------------------------------------------------------
#  slotNames(specLibrary@ionlibrary[[1]])
specLibrary@ionlibrary[[1]]

## ----plotSpecLibraryIons, fig.retina=3----------------------------------------
plot(specLibrary@ionlibrary[[1]])

## ----plotSpecLibrary, fig.retina=3--------------------------------------------
plot(specLibrary)

## ----write.spectronaut, eval=TRUE---------------------------------------------
write.spectronaut(specLibrary, file =  INPUT$OUTPUT_LIBRARY_FILE)

## ----save, eval=TRUE----------------------------------------------------------
save(specLibrary, file = INPUT$RDATA_LIBRARY_FILE)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

