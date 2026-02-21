# Raw mzXML data using Bioconductor’s ExperimentHub

#### Josie Hayes

#### October 30, 2025

# Adductomics analysis with Raw mzXML data using Bioconductor’s ExperimentHub

Data were produced on a LTQ Orbitrap XL HRMS coupled with a Dionex Ultimate 3000 nanoflow LC system via a Flex Ion nano-electrospray-ionization source according to methods in Grigoryan et al (Anal Chem. 2016 Nov 1; 88(21): 10504–10512.). RAW files were converted to mzXML using ProteoWizard msConvert.

```
msconvert ORB35017raw.RAW --mzXML
msconvert ORB35017raw.RAW --mzXML
```

The other files were produced using the package adductomicsR

```
# load the package
library(adductData)
```

rtDevModels.RData can be produced using:

```
rtDevModelling(MS2Dir = system.file("extdata", package = "adductData"),
nCores=4, runOrder = paste0(system.file("extdata", package = "adductomicsR"),
'/runOrder.csv'))

#access the files using ExperimentHub
library(ExperimentHub)
eh  = ExperimentHub()
temp = query(eh, 'adductData')
temp
```

adductQuantResults.RData can be produced using:

```
adductQuant(nCores=4, targTable=paste0(system.file("extdata",
package = "adductomicsR"),'/exampletargTable2.csv'), intStdRtDrift=30,
rtDevModels=paste0(system.file("extdata", package = "adductData"),
'/rtDevModels.RData'),
filePaths=list.files(system.file("extdata", package = "adductData"),
    pattern=".mzXML", all.files=FALSE,full.names=TRUE),
quantObject=NULL,indivAdduct=NULL,maxPpm=5,minSimScore=0.8,spikeScans=1,
minPeakHeight=100,maxRtDrift=20,maxRtWindow=240,isoWindow=80,
hkPeptide='LVNEVTEFAK', gaussAlpha=16)

#access the files using ExperimentHub
library(ExperimentHub)
eh  = ExperimentHub()
temp = query(eh, 'adductData')
temp
```