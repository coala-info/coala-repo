# Example Workflow using the `tofsims` package

#### *2019-01-04*

## Abstract

The `tofsims` package is a toolbox for importing, processing and analysing Time-of-Flight Secondary Ion Mass Spectrometry (ToF-SIMS) data. It currently supports the two most common commercial instrument platforms.

ToF-SIMS is a well established mass spectrometry technique with impressive figures of merit for chemical imaging (Belu, Graham, and Castner 2003, Fletcher and Vickerman (2013)). However, due to a number of reasons, ToF-SIMS instruments are not common in life science labs and experiments are therefore usually performed at specialized facilities. The `tofsims` package targets biologists and bioinformaticians who have their samples analyzed by a ToF-SIMS facility and need tools to analyze the obtained rawdata by temselves.

Other R packages availavle for processing and analysis of Imaging Mass Spectrometry (IMS) data are MALDIquant (Gibb and Strimmer 2012) and Caridnal (Bemis et al. 2015), however both without support for ToF-SIMS experiments. Outside of R, a non open-source package for Matlab (Graham 2014) and a commercial toolbox also for Matlab are the few options to the instrument manufacturers tools.

This vignette showcases a user session using the most common methods available in the `tofsims` package.

## Workflow

### Loading Spectra Data

The `tofsims` package has import functions for both pre-processed binary files of type *BIF/BIF6* and raw data from two popular ToF-SIMS platforms (*ULVAC-Phi*, *IONTOF*). The former are imported directly using the `MassImage()` function with the *select* arguments *ulvacbif* or *iontofbif*. The latter require additional steps as shown in the figure below. ![Raw data import scheme](data:image/png;base64...)

For the following session, an ‘ULVAC-Phi’ rawdata file is first imported as a spectrum. The binary file is stored in the */rawdata* directory of *tofsimsData* package. The *select* argument of `MassSpectra()` has the options *ulvacraw* and *iontofraw*:

```
library(tofsims)
library(tofsimsData)

### get path to raw data file
rawData<-system.file('rawdata', 'trift_test_001.RAW', package="tofsimsData")
### the following param will cause to run non parallel
library(BiocParallel)
register(SnowParam(workers=0), default=TRUE)
spectraImport<-MassSpectra(select = 'ulvacraw', analysisName = rawData)
```

`show()` returns a summary of the created MassSpectra object and `plot()` can be used to visualize the imported spectra:

```
show(spectraImport)
```

```
##         analysisName instrument no.spectra spectra.points total.ion.count
## 1 trift_test_001.RAW   ulvacphi          1        162'255       2'033'289
##   analysis
## 1     none
```

```
plot(spectraImport, mzRange=c(1,150), type='l')
```

![](data:image/png;base64...)

### Mass Calibration

Functions for mass calibration can be used on-screen or with arguments for batch processing of multiple files. If no *value* argument is provided, the user is prompted in the plot window.

```
spectraImport <- calibPointNew(object = spectraImport, mz = 15, value = 15.0113)
spectraImport <- calibPointNew(object = spectraImport, mz = 181, value = 181.0444)
spectraImport <- recalibrate(spectraImport)
```

### Creating a Peaklist

`unitMassPeaks()`is used to construct a peaklist for image import. Functions for more advanced peak picking are described in the package and upcoming vignettes. However, for image data with low spectral resolution, unit mass resolution is often sufficient. When the `lower` and/or `upper` argument are/is left out, peak width at the chosen M/z’s (`widthAt`) is chosen on-screen. The `factor` argument allows choosing assymetric peak widths. Peak widths are interpolated linear between the two *M/z* chosen in `widthAt`.

```
spectraImport <- unitMassPeaks(object = spectraImport,
mzRange = c(1,250),
widthAt = c(15,181),
factor = c(0.4, 0.6),
lower = c(14.96283,15.05096),
upper = c(180.80902,181.43538))

plot(spectraImport, mzRange=c(35,45), type='l')
```

![](data:image/png;base64...)

### Importing/Loading Image Data

Now, the experiment can be imported with the peak list as image data followed by poisson scaling. Poisson scaling is commonly used on ToF-SIMS data (Keenan and Kotula 2004). Visualization of image data is by the `image()` function.

```
library(RColorBrewer)
imageImport<-MassImage(select = 'ulvacrawpeaks',
analysisName = rawData,
PeakListobj = spectraImport)
imageImport <- poissonScaling(imageImport)
image(imageImport, col=brewer.pal(9, 'PuRd'))
```

![](data:image/png;base64...)

### Multivariate Image Analysis

Various multivariate analysis methods are implemented. Here, Principal Component Analysis (PCA) (Wold, Esbensen, and Geladi 1987) and Maximum Autocorrelation Factors (MAF) (Switzer and Green 1984) are shown. While PCA is used for dimension reduction in a wide range of applications, MAF is specifc for spatial datasets. Its usefulness has been demonstrated for ToF-SIMS imaging datasets (Henderson, Fletcher, and Vickerman 2009). Other methods available in the *tofsims* package are Multivariate Curve Resolution (MCR) (Jaumot and Tauler 2015) and Minimum Noise Fraction (MNF) (Stone et al. 2012).

```
imageImport <- PCAnalysis(imageImport, nComp = 4)
imageImport <- MAF(imageImport, nComp = 4)
par(mar=c(0,0,0,0), oma=c(0,0,0,0), mfrow=c(2,4))
for(iii in 1:4) image(analysis(imageImport, 1), comp=iii)
for(iii in 1:4) image(analysis(imageImport, 2), comp=iii)
```

![](data:image/png;base64...)

### Image Analysis

The `EBImage` package from Bioconductor (Pau et al. 2010) can be used for segmentation of ToF-SIMS image data. A typical workflow is to choose a principal component that contains chemical features of interest and convert it by threshholding into a black and white mask.

```
library(EBImage)
pcaScore3<-imageMatrix(analysis(imageImport, 1), comp=3)
pcaScore3Mask<-thresh(x = pcaScore3, h = 30, w = 30)
par(mar=c(0,0,0,0), oma=c(0,0,0,0))
image(pcaScore3Mask, col=c('white', 'black'))
```

![](data:image/png;base64...)

The mask can be used directly for area quantitations.

```
paste(round(100/(xy(imageImport)[1]*xy(imageImport)[2])*sum(pcaScore3Mask),2),
' % of the image is Cell Wall')
```

```
## [1] "49.77  % of the image is Cell Wall"
```

The mask can also be modified by the tools available in `EBImage`. Below the morphology operations ‘opening’ and ‘closing’ are shown.

```
opened<-opening(pcaScore3Mask, kern = makeBrush(3, shape = 'diamond'))
closed<-closing(pcaScore3Mask, kern = makeBrush(3, shape = 'diamond'))
par(mar=c(0,0,0,0), oma=c(0,0,0,0), mfcol=c(1,2))
image(opened, col = c('white', 'black'))
image(closed, col = c('white','black'))
```

![](data:image/png;base64...)

Masks can then be applied back to the original image to select and visualize specific compound mass spectra. In the example below the ‘opened’ mask is applied on the original imported image. This operation removes all signal from the area which was shown white in the mask. Multiple masks, for example from different PCA components can as such be used for image segmentation.

```
cellWall<-bwApply(imageImport,(opened-1)^2)
par(mar=c(0,0,0,0), oma=c(0,0,0,0), mfcol=c(1,2))
image(cellWall,col=brewer.pal(9, 'PuRd'))
image(imageImport,col=brewer.pal(9, 'PuRd'))
```

![](data:image/png;base64...)

## References

Belu, Anna M., Daniel J. Graham, and David G. Castner. 2003. “Time-of-Flight Secondary Ion Mass Spectrometry: Techniques and Applications for the Characterization of Biomaterial Surfaces.” *Biomaterials* 24 (21):3635–53. [https://doi.org/http://dx.doi.org/10.1016/S0142-9612(03)00159-5](https://doi.org/http%3A//dx.doi.org/10.1016/S0142-9612%2803%2900159-5).

Bemis, Kyle D., April Harry, Livia S. Eberlin, Christina Ferreira, Stephanie M. van de Ven, Parag Mallick, Mark Stolowitz, and Olga Vitek. 2015. “Cardinal: An R Package for Statistical Analysis of Mass Spectrometry-Based Imaging Experiments.” *Bioinformatics* 31 (14):2418–20. <https://doi.org/10.1093/bioinformatics/btv146>.

Fletcher, John S., and John C. Vickerman. 2013. “Secondary Ion Mass Spectrometry: Characterizing Complex Samples in Two and Three Dimensions.” *Analytical Chemistry* 85 (2):610–39. <https://doi.org/10.1021/ac303088m>.

Gibb, Sebastian, and Korbinian Strimmer. 2012. “MALDIquant: A Versatile R Package for the Analysis of Mass Spectrometry Data.” *Bioinformatics* 28 (17). Oxford University Press:2270–1. <https://doi.org/10.1093/bioinformatics/bts447>.

Graham, Dan. 2014. “NBToolbox.” <http://www.nb.uw.edu/mvsa/multivariate-surface-analysis-homepage>.

Henderson, Alex, John S. Fletcher, and John C. Vickerman. 2009. “A Comparison of Pca and Maf for Tof-Sims Image Interpretation.” *Surface and Interface Analysis* 41 (8):666–74. <https://doi.org/10.1002/sia.3084>.

Jaumot, Joaquim, and Roma Tauler. 2015. “Potential Use of Multivariate Curve Resolution for the Analysis of Mass Spectrometry Images.” *Analyst* 140 (3). The Royal Society of Chemistry:837–46. <https://doi.org/10.1039/C4AN00801D>.

Keenan, Michael R., and Paul G. Kotula. 2004. “Accounting for Poisson Noise in the Multivariate Analysis of Tof-Sims Spectrum Images.” *Surface and Interface Analysis* 36 (3):203–12. <https://doi.org/10.1002/sia.1657>.

Pau, Grégoire, Florian Fuchs, Oleg Sklyar, Michael Boutros, and Wolfgang Huber. 2010. “EBImage—an R Package for Image Processing with Applications to Cellular Phenotypes.” *Bioinformatics* 26 (7):979–81. <https://doi.org/10.1093/bioinformatics/btq046>.

Stone, Glenn, David Clifford, Johan OR Gustafsson, Shaun R McColl, and Peter Hoffmann. 2012. “Visualisation in Imaging Mass Spectrometry Using the Minimum Noise Fraction Transform.” *BMC Research Notes* 5. BioMed Central:419–19. <https://doi.org/10.1186/1756-0500-5-419>.

Switzer, Paul, and Andrew A. Green. 1984. “Min/Max Autocorrelation Factors for Multivariate Spatial Imagery: Technical Report 6.” Stanford, California: Department of Statistics, Stanford University. <https://statistics.stanford.edu/sites/default/files/SWI%20NSF%2006.pdf>.

Wold, Svante, Kim Esbensen, and Paul Geladi. 1987. “Principal Component Analysis.” *Chemometrics and Intelligent Laboratory Systems* 2 (1–3):37–52. [https://doi.org/http://dx.doi.org/10.1016/0169-7439(87)80084-9](https://doi.org/http%3A//dx.doi.org/10.1016/0169-7439%2887%2980084-9).