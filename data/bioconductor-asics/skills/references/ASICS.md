# Automatic Statistical Identification in Complex Spectra (ASICS)

#### Gaëlle Lefort, Rémi Servien and Nathalie Vialaneix

#### 2025-10-29

## Package description

The **R** package `ASICS` is a fully automated procedure to identify and quantify metabolites in \(^1\)H 1D-NMR spectra of biological mixtures (Tardivel *et al.*, 2017). It will enable empowering NMR-based metabolomics by quickly and accurately helping experts to obtain metabolic profiles. In addition to the quantification method, several functions allowing spectrum preprocessing or statistical analyses of quantified metabolites are available.

The full ASICS User’s Guide is available after installing the package. It can be opened with:

```
library(ASICS)
ASICSUsersGuide(view = FALSE)
```

```
## [1] "/tmp/RtmpOryT4N/Rinst3405991942d178/ASICS/doc/ASICSUsersGuide.html"
```

## Quick overview of main functions

Data are imported in a data frame from Bruker files with the `importSpectraBruker` function.

```
current_path <- system.file("extdata", "example_spectra", package = "ASICS")
spectra_data <- importSpectraBruker(current_path)
```

Then, from the data frame, a `Spectra` object is created. This is a required step for the quantification.

```
spectra_obj <- createSpectra(spectra_data)
```

Identification and quantification of metabolites can now be carried out using only the function `ASICS`.

```
to_exclude <- matrix(c(4.5, 10), ncol = 2)
resASICS <- ASICS(spectra_obj, exclusion.areas = to_exclude, verbose = FALSE)
```

Some analysis functions can be carried out on the quantification results. More details can be found in the user’s guide with the use of a real dataset.

## References

Tardivel P., Canlet C., Lefort G., Tremblay-Franco M., Debrauwer L., Concordet D., Servien R. (2017). ASICS: an automatic method for identification and quantification of metabolites in complex 1D 1H NMR spectra. *Metabolomics*, **13**(10): 109. <https://doi.org/10.1007/s11306-017-1244-5>