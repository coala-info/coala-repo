# Import FlowJo workspace to R

#### Mike Jiang

#### 2025-10-29

# 1 Basics

`CytoML` provides `flowjo_to_gatingset` function to parse `FlowJo` workspace (`xml` or `wsp` file) and FCS files into a self-contained `GatingSet` object, which captures the entire analysis recorded in flowJo, include `compensation`, `transformation` and `gating`.

## 1.1 open the workspace

```
library(CytoML)
dataDir <- system.file("extdata",package="flowWorkspaceData")
wsfile <- list.files(dataDir, pattern="manual.xml",full=TRUE)
ws <- open_flowjo_xml(wsfile)
ws
```

```
## File location:  /home/biocbuild/bbs-3.22-bioc/R/site-library/flowWorkspaceData/extdata/manual.xml
##
## Groups in Workspace
##          Name Num.Samples
## 1 All Samples          45
## 2      B-cell           4
## 3          DC           4
## 4      T-cell           4
## 5     Thelper           4
## 6        Treg           4
```

### 1.1.1 Extract groups from xml

Once opened, sample group information can be retrieved

```
tail(fj_ws_get_sample_groups(ws))
```

```
##    groupName groupID sampleID
## 60   Thelper       4       30
## 61   Thelper       4       31
## 62      Treg       5       37
## 63      Treg       5       38
## 64      Treg       5       39
## 65      Treg       5       40
```

### 1.1.2 Extract Samples from xml

And sample information for a given group

```
fj_ws_get_samples(ws, group_id = 5)
```

```
##   sampleID                    name  count pop.counts
## 1       28 CytoTrol_CytoTrol_1.fcs 136304         23
## 2       29 CytoTrol_CytoTrol_2.fcs 115827         23
## 3       30 CytoTrol_CytoTrol_3.fcs 123170         23
## 4       31 CytoTrol_CytoTrol_4.fcs 114802         23
```

### 1.1.3 Extract keywords from xml

keywords recorded in xml for a given sample

```
fj_ws_get_keywords(ws, 28)[1:5]
```

```
## $`$BEGINANALYSIS`
## [1] "0"
##
## $`$BEGINDATA`
## [1] "3241"
##
## $`$BEGINSTEXT`
## [1] "0"
##
## $`$BTIM`
## [1] "13:28:46"
##
## $`$BYTEORD`
## [1] "4,3,2,1"
```

## 1.2 Parse with default settings

In majority use cases, only two parameters are required to complete the parsing, i.e.

* `name`: the group to import
* `path`: the data path of FCS files.

### 1.2.1 select group

`name` parameter can be set to the group name displayed above through `flowJo_workspace` APIs.

```
gs <- flowjo_to_gatingset(ws, name = "T-cell")
```

`name` can also be the numeric index

```
gs <- flowjo_to_gatingset(ws, name = 4)
```

### 1.2.2 FCS path

As shown above, the `path` be omitted if fcs files are located at the same folder as xml file.

#### 1.2.2.1 string

Otherwise, `path` is set the actual folder where FCS files are located. The folder can contain sub-folders and the parser will recursively look up the directory for FCS files (by matching the file names, keywords, etc)

```
gs <- flowjo_to_gatingset(ws, name = 4, path = dataDir)
```

#### 1.2.2.2 data.frame

`path` can alternatively be a , which should contain two columns:‘sampleID’ and ‘file’. It essentially provides hardcoded mapping between ‘sampleID’ and FCS file (absolute) path to avoid the file system searching or sample matching process (between the flowJo sample reference and the FCS files).

However this is rarely needed since auto-searching does pretty accurate and robust matching.

# 2 Advanced

Due to the varieties of FlowJo workspace or FCS file issues, sometime the default setting won’t be sufficient to handle some edge cases, e.g. when the error occurs at specific gate due to the incorrect gate parameters defined in xml , but we want to be able to import the upstream gates that are still useful. Or there is letter case inconsistency for channels used in xml, which will trigger an error by default.

Also there are other features provided by the parser that allow users to speed up the parsing or extract more meta data from either xml or FCS files.

`flowjo_to_gatingset` provides more parameters that can be configured to solve different problems during the parsing. In document aims to go through these parameters and explore them one by one.

## 2.1 Parsing xml without loading FCS

It is possible to only import the gating structure without reading the FCS data by setting `execute` flag to `FALSE`.

```
gs <- flowjo_to_gatingset(ws, name = 4, execute = FALSE)
gs
```

```
## A GatingSet with 4 samples
```

Gating hierarchy is immediately available

```
suppressMessages(library(flowWorkspace))
plot(gs)
```

![](data:image/png;base64...)

So are the gates

```
gs_pop_get_gate(gs, "CD3+")
```

```
## $CytoTrol_CytoTrol_1.fcs_119531
## Ellipsoid gate 'CD3+' in dimensions <V450-A> and SSC-A
##
## $CytoTrol_CytoTrol_2.fcs_115728
## Ellipsoid gate 'CD3+' in dimensions <V450-A> and SSC-A
##
## $CytoTrol_CytoTrol_3.fcs_113883
## Ellipsoid gate 'CD3+' in dimensions <V450-A> and SSC-A
##
## $CytoTrol_CytoTrol_4.fcs_110898
## Ellipsoid gate 'CD3+' in dimensions <V450-A> and SSC-A
```

compensations

```
gs_get_compensations(gs)[1]
```

```
## $CytoTrol_CytoTrol_1.fcs_119531
## Compensation object 'defaultCompensation':
##          B710-A    G560-A    G780-A     R660-A    R780-A   V450-A   V545-A
## B710-A 1.000000 0.0009476  0.071170  0.0362400 0.1800000 0.007104 0.007608
## G560-A 0.115400 1.0000000  0.009097  0.0018360 0.0000000 0.000000 0.000000
## G780-A 0.014280 0.0380000  1.000000  0.0006481 0.1500000 0.000000 0.000000
## R660-A 0.005621 0.0000000  0.006604  1.0000000 0.1786000 0.000000 0.000000
## R780-A 0.000000 0.0000000  0.035340  0.0102100 1.0000000 0.000000 0.000000
## V450-A 0.000000 0.0000000 -0.060000 -0.0400000 0.0000000 1.000000 0.410000
## V545-A 0.002749 0.0000000  0.000000  0.0000000 0.0006963 0.035000 1.000000
```

transformations

```
gh_get_transformations(gs[[1]], channel = "B710-A")
```

```
## function (x, deriv = 0)
## {
##     deriv <- as.integer(deriv)
##     if (deriv < 0 || deriv > 3)
##         stop("'deriv' must be between 0 and 3")
##     if (deriv > 0) {
##         z0 <- double(z$n)
##         z[c("y", "b", "c")] <- switch(deriv, list(y = z$b, b = 2 *
##             z$c, c = 3 * z$d), list(y = 2 * z$c, b = 6 * z$d,
##             c = z0), list(y = 6 * z$d, b = z0, c = z0))
##         z[["d"]] <- z0
##     }
##     res <- stats:::.splinefun(x, z)
##     if (deriv > 0 && z$method == 2 && any(ind <- x <= z$x[1L]))
##         res[ind] <- ifelse(deriv == 1, z$y[1L], 0)
##     res
## }
## <bytecode: 0x5f68f5f31788>
## <environment: 0x5f6901992898>
## attr(,"type")
## [1] "biexp"
## attr(,"parameters")
## attr(,"parameters")$channelRange
## [1] 4096
##
## attr(,"parameters")$maxValue
## [1] 261589.9
##
## attr(,"parameters")$neg
## [1] 0
##
## attr(,"parameters")$pos
## [1] 4.5
##
## attr(,"parameters")$widthBasis
## [1] -10
```

and `stats`

```
head(gs_pop_get_stats(gs, xml = TRUE))
```

```
##                            sample                                   pop  count
##                            <char>                                <char>  <num>
## 1: CytoTrol_CytoTrol_1.fcs_119531                                  root 119531
## 2: CytoTrol_CytoTrol_1.fcs_119531                           /not debris  91720
## 3: CytoTrol_CytoTrol_1.fcs_119531                  /not debris/singlets  87033
## 4: CytoTrol_CytoTrol_1.fcs_119531             /not debris/singlets/CD3+  54737
## 5: CytoTrol_CytoTrol_1.fcs_119531         /not debris/singlets/CD3+/CD4  34083
## 6: CytoTrol_CytoTrol_1.fcs_119531 /not debris/singlets/CD3+/CD4/38- DR+   1124
```

Note that `xml` flag needs to be set in order to tell it to return the stats from xml file. Otherwise it will display the value computed from FCS file, which will be `NA` in this case since we didn’t load FCS files.

Apparently, it is very fast to only import xml, but data won’t be available for retrieving.

```
gs_pop_get_data(gs)
```

```
## Error: gate is not parsed!
```

## 2.2 Additional keys to tag samples

As shown above, the sample names appear to be the FCS filename appended with some numbers by default

```
sampleNames(gs)
```

```
## [1] "CytoTrol_CytoTrol_1.fcs_119531" "CytoTrol_CytoTrol_2.fcs_115728"
## [3] "CytoTrol_CytoTrol_3.fcs_113883" "CytoTrol_CytoTrol_4.fcs_110898"
```

These numbers are actually the value of `$TOT` keyword, which is the total number of events for each sample. This value is typically unique for each file thus is used to tag the sample on top of the existing sample name. This default behavior is recommended so that samples can be uniquely identified even when duplication of file names occur, which is not uncommon. e.g. We often see the multiple files are named as `Specimen_XXX` that are located under different sub-folders.

### 2.2.1 additional.keys

However, if users decide it is unnecessary in their case and prefer to the shorter names. It can be removed through `additional.keys` parameter

```
gs <- flowjo_to_gatingset(ws, name = 4, execute = FALSE, additional.keys = NULL)
sampleNames(gs)
```

```
## [1] "CytoTrol_CytoTrol_1.fcs" "CytoTrol_CytoTrol_2.fcs"
## [3] "CytoTrol_CytoTrol_3.fcs" "CytoTrol_CytoTrol_4.fcs"
```

Or it can be tagged by some extra keywords value if `$TOT` turns out to be not sufficient for the unique ID, which rarely happens.

```
gs <- flowjo_to_gatingset(ws, name = 4, execute = FALSE, additional.keys = c("$TOT", "EXPERIMENT NAME"))
sampleNames(gs)
```

```
## [1] "CytoTrol_CytoTrol_1.fcs_119531_C2_Tcell"
## [2] "CytoTrol_CytoTrol_2.fcs_115728_C2_Tcell"
## [3] "CytoTrol_CytoTrol_3.fcs_113883_C2_Tcell"
## [4] "CytoTrol_CytoTrol_4.fcs_110898_C2_Tcell"
```

### 2.2.2 additional.sampleID

And we can even include the `sample ID` used by flowJo xml when the filename and other keywords can’t be differentiated between samples. This can be turned on by `additional.sampleID` flag

```
gs <- flowjo_to_gatingset(ws, name = 4, execute = FALSE, additional.sampleID = TRUE)
sampleNames(gs)
```

```
## [1] "CytoTrol_CytoTrol_1.fcs_19_119531" "CytoTrol_CytoTrol_2.fcs_20_115728"
## [3] "CytoTrol_CytoTrol_3.fcs_21_113883" "CytoTrol_CytoTrol_4.fcs_22_110898"
```

## 2.3 Annotate sample with keywords

Be default, the pheno data of samples (returned by `pData()`) only contains single column of file name.

```
pData(gs)
```

```
##                                                      name
## CytoTrol_CytoTrol_1.fcs_19_119531 CytoTrol_CytoTrol_1.fcs
## CytoTrol_CytoTrol_2.fcs_20_115728 CytoTrol_CytoTrol_2.fcs
## CytoTrol_CytoTrol_3.fcs_21_113883 CytoTrol_CytoTrol_3.fcs
## CytoTrol_CytoTrol_4.fcs_22_110898 CytoTrol_CytoTrol_4.fcs
```

### 2.3.1 keywords

`keywords` can be specified to ask the parser to exact the keywords and attach them to the pdata.

```
gs <- flowjo_to_gatingset(ws, name = 4, execute = FALSE, additional.keys = NULL, keywords = c("EXPERIMENT NAME", "TUBE NAME"))
pData(gs)
```

```
##                                            name EXPERIMENT NAME  TUBE NAME
## CytoTrol_CytoTrol_1.fcs CytoTrol_CytoTrol_1.fcs        C2_Tcell CytoTrol_1
## CytoTrol_CytoTrol_2.fcs CytoTrol_CytoTrol_2.fcs        C2_Tcell CytoTrol_2
## CytoTrol_CytoTrol_3.fcs CytoTrol_CytoTrol_3.fcs        C2_Tcell CytoTrol_3
## CytoTrol_CytoTrol_4.fcs CytoTrol_CytoTrol_4.fcs        C2_Tcell CytoTrol_4
```

### 2.3.2 keywords.source

By default, `keywords` are parsed from xml file. Alternatively it can be read from FCS files by setting `keywords.source = "FCS"`. Obviously, `execute` needs to be set to `TRUE` in order for this to succeed.

### 2.3.3 keyword.ignore.case

Occasionally, keyword names may not be case consistent across samples, e.g. `tube name` vs `TUBE NAME`, which will prevent the parser from constructing the `pData` data structure properly.

`keyword.ignore.case` can be optionally set to `TRUE` in order to relax the rule to make the parser succeed. But it is recommended to keep it as default (especially when `keywords.source = "FCS"`) and use the dedicated tool `cytoqc` package to standardize `FCS` files before running the parser.

## 2.4 Import a subset

Sometime it is useful to only select a small subset of samples to import to quickly test or review the content of gating tree instead of waiting for the entire data set to be completed, which could take longer time if the total number of samples is big.

`subset` argument takes numeric indies, e.g.

```
gs <- flowjo_to_gatingset(ws, name = 4, execute = FALSE, additional.keys = NULL, subset = 1:2)
sampleNames(gs)
```

```
## [1] "CytoTrol_CytoTrol_1.fcs" "CytoTrol_CytoTrol_2.fcs"
```

or the vector of sample (FCS) names, e.g.

```
gs <- flowjo_to_gatingset(ws, name = 4, execute = FALSE, additional.keys = NULL, subset = c("CytoTrol_CytoTrol_3.fcs"))
sampleNames(gs)
```

or an that is similar to the one passed to ‘base::subset’ function to filter a data.frame. Note that the columns referred by the expression must also be explicitly specified in ‘keywords’ argument, which we will cover in the later sections.

e.g.

```
gs <- flowjo_to_gatingset(ws, name = 4, execute = FALSE, additional.keys = NULL
                                                        , subset = `EXPERIMENT NAME` == "C2_Tcell"
                                                        , keywords = c("EXPERIMENT NAME")
                                                        )

pData(gs)
```

```
##                                            name EXPERIMENT NAME
## CytoTrol_CytoTrol_1.fcs CytoTrol_CytoTrol_1.fcs        C2_Tcell
## CytoTrol_CytoTrol_2.fcs CytoTrol_CytoTrol_2.fcs        C2_Tcell
## CytoTrol_CytoTrol_3.fcs CytoTrol_CytoTrol_3.fcs        C2_Tcell
## CytoTrol_CytoTrol_4.fcs CytoTrol_CytoTrol_4.fcs        C2_Tcell
```

## 2.5 Parallel parsing

It is possible to utilize multiple cpus (cores) to speed up the parsing where each sample is parsed and gated concurrently. Parallel parsing is enabled when `mc.cores` is set to the value > 1.

```
gs <- flowjo_to_gatingset(ws, name = 4, mc.cores = 4)
```

However, be careful to avoid setting too many cores, which may end up slowing down the process caused by disk IO because FCS files need to be read from disk and the type of file system also contributes to the performance. e.g. parallel file system provided by HPC usually performs better than the regular personal computer.

## 2.6 Skip leaf boolean gates

Sometime the gating tree could be big and could be slow to import all the gates, e.g.

```
gs <- flowjo_to_gatingset(ws, name="Samples", subset = "1379326.fcs", execute = FALSE)
nodes <- gs_get_pop_paths(gs)
length(nodes)
plot(gs, "3+")
```

it contains a lot of boolean gates at the bottom level of the tree, e.g.

```
tail(nodes, 10)
```

If these boolean gates are not important for the analysis, user can choose to skip computing them

```
gs <- flowjo_to_gatingset(ws, name="Samples", subset = "1379326.fcs", leaf.bool = F)
gs_pop_get_stats(gs)
```

As shown, these boolean leaf gates are still imported, but not gated or computed (which is why stats are NA for these gates). This will speed up the parsing by avoid calculating significant portion of the tree. And it can be computed later if user decides to do so

```
recompute(gs)
gs_pop_get_stats(gs)
```

## 2.7 Skip faulty gates

```
gs <- flowjo_to_gatingset(ws, name = 4, path = dataDir, subset = 1)
```

This parsing error is due to the incorrect channel name is used by `CD4` gate that is defined in flowJo and FCS files don’t have that channel

```
gs <- flowjo_to_gatingset(ws, name = 4, path = dataDir, execute = FALSE)
plot(gs)
gs_pop_get_gate(gs, "CD4")[[1]]
```

The parser can be told to skip `CD4` and all its descendants so that the rest of gates can still be parsed

```
gs <- flowjo_to_gatingset(ws, name = 4, path = dataDir, subset = 1, skip_faulty_gate = TRUE)
head(gs_pop_get_stats(gs))
```

Similar to skipping leaf boolean gates, faulty gates are still imported, but they are not computed.

## 2.8 Import the empty gating tree

```
gs <- flowjo_to_gatingset(ws, name = 1, path = dataDir)
```

This parsing error is actually due to the fact that the flowJo workspace doesn’t have any gates defined. We can see that through

```
fj_ws_get_samples(ws)
```

By default, parser will ignore and skip any sample that has zero `population`s (consider them as invalid entries in xml). This is why it gives the message of no samples to parse.

User can choose to import it anyway (so that he can get FCS files to be compensated and transformed by flowJo xml),

```
gs <- flowjo_to_gatingset(ws, name = 1, path = dataDir, include_empty_tree = TRUE)
range(gs_cyto_data(gs)[[1]])
```

## 2.9 Customized fcs file extension

This will fail to find the samples.

```
gs <- flowjo_to_gatingset(ws, name = 1, path = dataDir, additional.keys = NULL)
```

As the error message indicates, FCS file has the non-conventional extention `.B08` other than `.fcs`. Parser can be configured to search for the customized fcs files.

```
gs <- flowjo_to_gatingset(ws, name = 1, path = dataDir, additional.keys = NULL, fcs_file_extension = ".B08")
sampleNames(gs)
```