# Code example from 'Using_MSGFplus' vignette. See references/ for full tutorial.

## ---- eval=TRUE, echo=FALSE, results='hide', message=FALSE---------------
require(MSGFplus)

## ---- eval=TRUE, echo=TRUE-----------------------------------------------
par <- msgfPar()
show(par)

## ---- eval=TRUE, echo=TRUE-----------------------------------------------
databaseFile <- system.file('extdata', 'milk-proteins.fasta', package='MSGFplus')
db(par) <- databaseFile

## ---- eval=TRUE, echo=TRUE-----------------------------------------------
tolerance(par) <- '20 ppm'      # Set parent ion tolerance
chargeRange(par) <- c(2, 6)     # Set the range of charge states to look after
lengthRange(par) <- c(6, 25)    # Set the range of peptide length to look after
instrument(par) <- 'QExactive'  # Set the instrument used for acquisition
enzyme(par) <- 'Trypsin'        # Set the enzyme used for digestion
fragmentation(par) <- 0         # Set the fragmentation method
protocol(par) <- 0              # Set the protocol type
isotopeError(par) <- c(0,2)     # Set the isotope error
matches(par) <- 2               # Set the number of matches to report per scan
ntt(par) <- 1                   # Set number of tolerable termini
tda(par) <- TRUE                # Use target decoy approach

par

## ---- eval=TRUE, echo=TRUE-----------------------------------------------
mods(par)[[1]] <- msgfParModification(name = 'Carbamidomethyl', 
                                      composition = 'C2H3N1O1', 
                                      residues = 'C', 
                                      type = 'opt', 
                                      position = 'any')
mods(par)[[2]] <- msgfParModification(name = 'Oxidation', 
                                      mass = 15.994915, 
                                      residues = 'M', 
                                      type = 'opt', 
                                      position = 'any')
nMod(par) <- 2                  # Set max number of modifications per peptide

par

## ---- eval=TRUE, echo=TRUE-----------------------------------------------
par <- msgfPar(database = databaseFile, 
               tolerance = '20 ppm', 
               tda=TRUE,
               instrument='QExactive')

par

## ---- eval=FALSE, echo=TRUE, results='hide'------------------------------
#  par <- msgfParFromID('/path/to/results/file.mzid')
#  
#  par

## ---- eval=FALSE---------------------------------------------------------
#  require(gWidgets)
#  
#  par <- msgfParGUI()

## ---- eval=FALSE, echo=TRUE----------------------------------------------
#  res <- runMSGF(par, 'your_rawfile.mzML')

## ---- eval=FALSE, echo=TRUE----------------------------------------------
#  msgf <- runMSGF(par, 'your_rawfile.mzML', async=TRUE)
#  
#  while(running(msgf)) {
#      Sys.sleep(1)             # You could arguably do more meaningfull stuff here
#  }
#  if(finished(msgf)) {
#      res <- import(msgf)
#  }

## ---- eval=TRUE, echo=TRUE-----------------------------------------------
sessionInfo()

