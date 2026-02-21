# Code example from 'TargetSearch' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----ImportSample----------------------------------------------------------
library(TargetSearchData)
library(TargetSearch)
cdf.path <- tsd_data_path()
sample.file <- tsd_file_path("samples.txt")
samples <- ImportSamples(sample.file, CDFpath = cdf.path, RIpath = ".")

## ----ImportSample2---------------------------------------------------------
cdffiles <- dir(cdf.path, pattern="cdf$")
# take the measurement day info from the cdf file names.
days <- sub("^([[:digit:]]+).*$","\\1",cdffiles)
# sample names
smp_names <- sub("\\.cdf", "", cdffiles)
# add some sample info
smp_data <- data.frame(CDF_FILE =cdffiles, GROUP = gl(5,3))
# create the sample object
samples <- new("tsSample", Names = smp_names, CDFfiles = cdffiles,
               CDFpath = cdf.path, RIpath = ".", days = days,
               data = smp_data)

## ----ImportFameSettings----------------------------------------------------
rim.file  <- tsd_file_path("rimLimits.txt")
rimLimits <- ImportFameSettings(rim.file, mass = 87)

## ----checkRimLim, fig.cap="Example of the RI markers $m/z$ traces in samples"----
checkRimLim(samples[1:3], rimLimits, single=FALSE, col=2:4, lty=1)

## ----ncdf4-----------------------------------------------------------------
samples <- ncdf4Convert(samples, path=".")

## ----baseline, eval=FALSE--------------------------------------------------
# samples <- ncdf4Convert(samples, path=".", baseline=TRUE, bsline_method="quantiles", ...)

## ----RIcorrection----------------------------------------------------------
RImatrix <- RIcorrect(samples, rimLimits, IntThreshold = 100,
		      pp.method = "ppc", Window = 15)

## ----PeakIdentification----------------------------------------------------
outliers <- FAMEoutliers(samples, RImatrix, threshold = 3)

## ----plotFAME, fig.cap="Retention Index Marker 1.", fig.small='TRUE'-------
plotFAME(samples, RImatrix, 1)

## ----ImportLibrary---------------------------------------------------------
lib.file <- tsd_file_path("library.txt")
lib      <- ImportLibrary(lib.file, RI_dev = c(2000,1000,200),
            TopMasses = 15, ExcludeMasses = c(147, 148, 149))

## ----LibrarySearch1--------------------------------------------------------
lib <- medianRILib(samples, lib)

## ----medianLib, fig.cap="RI deviation of first 9 metabolites in the library", fig.dim=c(8,8), fig.wide=TRUE, out.width='95%', echo=FALSE----
resPeaks <- FindPeaks(RIfiles(samples), refLib(lib, w = 1, sel = TRUE))
plotRIdev(lib, resPeaks, libID = 1:9)

## ----LibrarySearch2--------------------------------------------------------
cor_RI <- sampleRI(samples, lib, r_thres = 0.95,
                     method = "dayNorm")

## ----LibrarySearch3--------------------------------------------------------
peakData <- peakFind(samples, lib, cor_RI)

## ----LibrarySearch4--------------------------------------------------------
met.RI        <- retIndex(peakData)
met.Intensity <- Intensity(peakData)
# show the intensity values of the first metabolite.
met.Intensity[[1]]

## ----MetaboliteProfile-----------------------------------------------------
MetabProfile <- Profile(samples, lib, peakData, r_thres = 0.95,
                      method = "dayNorm")

## ----MetaboliteProfile2----------------------------------------------------
finalProfile <- ProfileCleanUp(MetabProfile, timeSplit = 500,
                                r_thres = 0.95)

## ----plotSpectra, fig.cap="Spectra comparison of ``Valine''"---------------
grep("Valine", libName(lib))
plotSpectra(lib, peakData, libID = 3, type = "ht")

## ----plotPeak, fig.cap="Chromatographic peak of Valine."-------------------
# we select the first sample
sample.id <- 1
cdf.file  <- tsd_file_path(cdffiles[sample.id])
rawpeaks  <- peakCDFextraction(cdf.file)
# which.met=3 (id of Valine)
plotPeak(samples, lib, MetabProfile, rawpeaks, which.smp=sample.id,
    which.met=3, corMass=FALSE)

## ----untargeted1-----------------------------------------------------------
metRI    <- seq(200000, 300000, by = 5000)
metMZ    <- 85:250
metNames <- paste("Metab",format(metRI,digits=6), sep = "_")

## ----untargeted2-----------------------------------------------------------
metLib   <- new("tsLib", Name = metNames, RI = metRI,
     selMass = rep(list(metMZ), length(metRI)), RIdev = c(3000, 1500, 500))

## ----untargeted3-----------------------------------------------------------
metLib <- medianRILib(samples, metLib)
metCorRI <- sampleRI(samples, metLib)
metPeakData <- peakFind(samples, metLib, metCorRI)
metProfile <- Profile(samples, metLib, metPeakData)
metFinProf <- ProfileCleanUp(metProfile, timeSplit = 500)

## ----untargeted4-----------------------------------------------------------
sum(  profileInfo(metFinProf)$Mass_count > 5)
tmp   <-  profileInfo(metFinProf)$Mass_count > 5
metRI    <- profileInfo(metFinProf)$RI[tmp]
metNames <-  as.character( profileInfo(metFinProf)$Name[tmp] )
metMZ <- sapply(profileInfo(metFinProf)$Masses[tmp],
	function(x) as.numeric(unlist(strsplit(x,";"))) )
metLib   <- new("tsLib", Name = metNames, RI = metRI,
     selMass = metMZ, RIdev = c(1500, 750, 250))

## ----sessionInfo, results="asis", echo=FALSE-------------------------------
toLatex(sessionInfo())

