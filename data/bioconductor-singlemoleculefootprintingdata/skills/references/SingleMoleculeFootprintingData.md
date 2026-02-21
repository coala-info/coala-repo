# SingleMoleculeFootprintingData

```
library(SingleMoleculeFootprintingData)
```

The data objects provided with SingleMoleculeFootprintingData can be downloaded and cached using the dedicated accessor functions. Here we exemplify how to access the index to the bam file containing example SMF sequencing data.

```
SingleMoleculeFootprintingData::NRF1pair.bam.bai()
#> see ?SingleMoleculeFootprintingData and browseVignettes('SingleMoleculeFootprintingData') for documentation
#> loading from cache
#>                                                       EH5435
#> "/home/biocbuild/.cache/R/ExperimentHub/19222e290285e1_5478"
```

N.b.: users of the SingleMoleculeFootprinting pkg do not need to manually download and cache SingleMoleculeFootprintingData objects since we perform this task under the hood in the vignette of SingleMoleculeFootprinting. This is to create the QuasR input file pointing at the example NRF1pair data necessary to run the vignette itself.