# How to import Cytobank into a GatingSet

#### Mike Jiang

This vignette demonstrates how the gatingML files exported from Cytobank can be imported into R as a GatingSet object.

```
library(flowWorkspace)
library(CytoML)
acs <- system.file("extdata/cytobank_experiment.acs", package = "CytoML")
```

Create `cytobank_experiment` object from the ACS bundle exported from Cytobank

```
ce <- open_cytobank_experiment(acs)
ce
```

```
## cytobank Experiment:  tcell
## gatingML File:  /tmp/RtmptNmzia/file3e2aad7a2bb7b/experiments/3637/cytobank_gate_ml2_v41.xml
##     panel samples
## 1 Panel 1       1
```

**cytobank\_experiment** is a wrapper around the `ACS` file, which can be inspected by various accessors.

```
sampleNames(ce)
```

```
## [1] "CytoTrol_CytoTrol_1.fcs"
```

```
ce_get_panels(ce)
```

```
## # A tibble: 1 × 2
##   panel   samples
##   <chr>     <int>
## 1 Panel 1       1
```

```
ce_get_compensations(ce)
```

```
## $`CytoTrol_CytoTrol_1.fcs - spill string`
##             B710-A      R660-A      R780-A      V450-A     V545-A      G560-A
## B710-A 1.00000e+00 3.14389e-02 0.190966000 0.003057570 0.00204723 3.44241e-04
## R660-A 5.53798e-03 1.00000e+00 0.176812000 0.000000000 0.00000000 0.00000e+00
## R780-A 9.95863e-05 9.84766e-03 1.000000000 0.000000000 0.00000000 0.00000e+00
## V450-A 0.00000e+00 8.90985e-05 0.000000000 1.000000000 0.45119500 1.08275e-04
## V545-A 2.47709e-03 5.23516e-04 0.000000000 0.037961500 1.00000000 6.36181e-05
## G560-A 1.17224e-01 1.64272e-03 0.000332153 0.000000000 0.00000000 1.00000e+00
## G780-A 1.42052e-02 4.56896e-04 0.175402000 0.000089025 0.00000000 4.09687e-02
##            G780-A
## B710-A 0.07193380
## R660-A 0.00661890
## R780-A 0.03539970
## V450-A 0.00000000
## V545-A 0.00000000
## G560-A 0.00921936
## G780-A 1.00000000
##
## $`CytoTrol_CytoTrol_1.fcs - spill string`
##             B710-A      R660-A      R780-A      V450-A     V545-A      G560-A
## B710-A 1.00000e+00 3.14389e-02 0.190966000 0.003057570 0.00204723 3.44241e-04
## R660-A 5.53798e-03 1.00000e+00 0.176812000 0.000000000 0.00000000 0.00000e+00
## R780-A 9.95863e-05 9.84766e-03 1.000000000 0.000000000 0.00000000 0.00000e+00
## V450-A 0.00000e+00 8.90985e-05 0.000000000 1.000000000 0.45119500 1.08275e-04
## V545-A 2.47709e-03 5.23516e-04 0.000000000 0.037961500 1.00000000 6.36181e-05
## G560-A 1.17224e-01 1.64272e-03 0.000332153 0.000000000 0.00000000 1.00000e+00
## G780-A 1.42052e-02 4.56896e-04 0.175402000 0.000089025 0.00000000 4.09687e-02
##            G780-A
## B710-A 0.07193380
## R660-A 0.00661890
## R780-A 0.03539970
## V450-A 0.00000000
## V545-A 0.00000000
## G560-A 0.00921936
## G780-A 1.00000000
##
## $`CytoTrol_CytoTrol_1.fcs - spill string`
##             B710-A      R660-A      R780-A      V450-A     V545-A      G560-A
## B710-A 1.00000e+00 3.14389e-02 0.190966000 0.003057570 0.00204723 3.44241e-04
## R660-A 5.53798e-03 1.00000e+00 0.176812000 0.000000000 0.00000000 0.00000e+00
## R780-A 9.95863e-05 9.84766e-03 1.000000000 0.000000000 0.00000000 0.00000e+00
## V450-A 0.00000e+00 8.90985e-05 0.000000000 1.000000000 0.45119500 1.08275e-04
## V545-A 2.47709e-03 5.23516e-04 0.000000000 0.037961500 1.00000000 6.36181e-05
## G560-A 1.17224e-01 1.64272e-03 0.000332153 0.000000000 0.00000000 1.00000e+00
## G780-A 1.42052e-02 4.56896e-04 0.175402000 0.000089025 0.00000000 4.09687e-02
##            G780-A
## B710-A 0.07193380
## R660-A 0.00661890
## R780-A 0.03539970
## V450-A 0.00000000
## V545-A 0.00000000
## G560-A 0.00921936
## G780-A 1.00000000
```

```
ce_get_samples(ce)
```

```
## # A tibble: 1 × 2
##   panel   sample
##   <chr>   <chr>
## 1 Panel 1 CytoTrol_CytoTrol_1.fcs
```

```
ce_get_channels(ce)
```

```
##  [1] "FSC-A"  "FSC-H"  "FSC-W"  "SSC-A"  "B710-A" "R660-A" "R780-A" "V450-A"
##  [9] "V545-A" "G560-A" "G780-A" "Time"
```

```
ce_get_markers(ce)
```

```
## $CytoTrol_CytoTrol_1.fcs
##  [1] "FSC-A"        "FSC-H"        "FSC-W"        "SSC-A"        "CD4"
##  [6] "CD38 APC"     "CD8 APCH7"    "CD3"          "HLA-DR V500"  "CCR7 PE"
## [11] "CD45RA PECy7" "Time"
```

```
pData(ce)
```

```
##                                            name Conditions Individuals
## CytoTrol_CytoTrol_1.fcs CytoTrol_CytoTrol_1.fcs condition1       ptid1
```

Then import `cytobank_experiment` into **GatingSet**

```
gs <- cytobank_to_gatingset(ce)
```

By default, the first `panel` (i.e. `panel_id = 1`) will be imported. Change `panel_id` argument to select different panel (if there are more than one , which can be inspected by `ce_get_panels` )

Alternatively, the import can be done by `gatingML` and `fcs` files that are downloaded separately form Cytobank without `ACS`.

```
xmlfile <- ce$gatingML
fcsFiles <- list.files(ce$fcsdir, full.names = TRUE)
gs <- cytobank_to_gatingset(xmlfile, fcsFiles)
```

However, it doesn’t have the information from `yaml` file (part of `ACS`). E.g. sample tags (i.e. `pData`) and customized markernames. So it is recommended to import `ACS`.

Inspect the results

```
library(ggcyto)
## Plot the gates
autoplot(gs[[1]])
```

![](data:image/png;base64...)

```
# Extract the population statistics
gs_pop_get_count_fast(gs, statType = "count")
```

```
##                        name                                     Population
##                      <char>                                         <char>
##  1: CytoTrol_CytoTrol_1.fcs                                    /not debris
##  2: CytoTrol_CytoTrol_1.fcs                           /not debris/singlets
##  3: CytoTrol_CytoTrol_1.fcs                       /not debris/singlets/CD3
##  4: CytoTrol_CytoTrol_1.fcs                   /not debris/singlets/CD3/CD8
##  5: CytoTrol_CytoTrol_1.fcs            /not debris/singlets/CD3/CD8/CD8_Q2
##  6: CytoTrol_CytoTrol_1.fcs                   /not debris/singlets/CD3/CD4
##  7: CytoTrol_CytoTrol_1.fcs                /not debris/singlets/CD3/CD4/Q1
##  8: CytoTrol_CytoTrol_1.fcs                /not debris/singlets/CD3/CD4/Q2
##  9: CytoTrol_CytoTrol_1.fcs                /not debris/singlets/CD3/CD4/Q4
## 10: CytoTrol_CytoTrol_1.fcs                /not debris/singlets/CD3/CD4/Q3
## 11: CytoTrol_CytoTrol_1.fcs /not debris/singlets/CD3/CD8/CD8_Q2/CD38 range
## 12: CytoTrol_CytoTrol_1.fcs  /not debris/singlets/CD3/CD8/CD8_Q2/HLA range
##                                  Parent Count ParentCount
##                                  <char> <int>       <int>
##  1:                                root 87876      119531
##  2:                         /not debris 79845       87876
##  3:                /not debris/singlets 53135       79845
##  4:            /not debris/singlets/CD3 12862       53135
##  5:        /not debris/singlets/CD3/CD8  2331       12862
##  6:            /not debris/singlets/CD3 33653       53135
##  7:        /not debris/singlets/CD3/CD4   419       33653
##  8:        /not debris/singlets/CD3/CD4 11429       33653
##  9:        /not debris/singlets/CD3/CD4  4119       33653
## 10:        /not debris/singlets/CD3/CD4 17686       33653
## 11: /not debris/singlets/CD3/CD8/CD8_Q2  2331        2331
## 12: /not debris/singlets/CD3/CD8/CD8_Q2  2315        2331
```