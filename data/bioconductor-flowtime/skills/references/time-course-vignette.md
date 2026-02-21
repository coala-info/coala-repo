# Time course analysis of flow cytometry data

#### R Clay Wright

#### 2025-10-30

This vignette will guide you through analysis of an example flow cytometry data set from an experiment examining time-lapse florescence reporter levels from a synthetic biological circuit in liquid cultures of budding yeast. In this example circuit, fluorescent reporter expression is mediated by a transcription factor/transcriptional repressor complex. The transcriptional repressor is degraded via the ubiquitin proteasome system, in response to a small molecule. Fluorescence levels are measured approximately every 10 minutes by flow cytometry. Here we demonstrate how to import the resulting .fcs files into R, gate and annotate this data with experimental metadata (e.g. the `strain` and `treatment` for each sample), generate summary statistics for each sample and time point and finally plot this data (in this case, activation curves).

#Importing and annotating data Import your flow cytometry data using `read.flowset`. Here, we will import an example flowSet.

```
plate1 <- read.flowSet(path = system.file("extdata", "tc_example", package = "flowTime"),
    alter.names = TRUE)
# add plate numbers to the sampleNames, in this example we have already done
# this step sampleNames(plate1)<-paste('1_',sampleNames(plate1),sep='')
dat <- plate1
```

If you have several plates this code can be repeated and each plate can be combined (using `rbind2`) to assemble the full data set.

```
plate2 <- read.flowSet(path = paste(experiment, "_2/", sep = ""), alter.names = TRUE)
sampleNames(plate2) <- paste("2_", sampleNames(plate2), sep = "")
dat <- rbind2(plate1, plate2)
```

Now we import the table of metadata.

```
annotation <- read.csv(system.file("extdata", "tc_example.csv", package = "flowTime"))
```

The `sampleNames` of the assembled `flowSet` (`dat` in this example) must match that of a unique identifier column of `annotation`. We can also create this column from our data set and attach the annotation columns. The order of the unique identifier column does not matter, as `annotateFlowSet` will join `annotation` to `dat` by matching identifiers.

```
sampleNames(dat)  # view the sample names
sampleNames(dat) == annotation$id
# Replace 'id' with the unique identifier column to test, if this column is
# identical to the sample names of your flowset.
annotation <- cbind(annotation, names = sampleNames(dat))
# If the sampleNames and unique identifiers are in the correct order this
# command will add the sampleNames as the identifier.
```

Finally we can attach this metadata to the flowSet using the `annotateFlowSet` function.

```
adat <- annotateFlowSet(dat, annotation)
head(rownames(pData(adat)))
#> [1] "0_A08.fcs" "0_B08.fcs" "0_C08.fcs" "0_D08.fcs" "0_E08.fcs" "0_F08.fcs"
head(pData(adat))
#>                name     X strain     RD ARF  AFB treatment
#> 0_A08.fcs 0_A08.fcs 0_A08      3 TPLRD1  19 AFB2         0
#> 0_B08.fcs 0_B08.fcs 0_B08      3 TPLRD1  19 AFB2         0
#> 0_C08.fcs 0_C08.fcs 0_C08      3 TPLRD1  19 AFB2         0
#> 0_D08.fcs 0_D08.fcs 0_D08      3 TPLRD1  19 AFB2         0
#> 0_E08.fcs 0_E08.fcs 0_E08      3 TPLRD1  19 AFB2         0
#> 0_F08.fcs 0_F08.fcs 0_F08      3 TPLRD1  19 AFB2         0
```

Now we can save this flowSet and anyone in perpetuity can load and analyze this annotated flowSet with ease!

```
write.flowSet(adat, outdir = "your/favorite/directory")
read.flowSet("flowSet folder", path = "your/flow/directory", phenoData = "annotation.txt",
    alter.names = TRUE)
```

#Compiling and plotting data Now we are ready to analyze the raw data in this `flowSet`. For this time-course experiment we will use the `summarizeFlow` function. This function will gate each `flowFrame` in the `flowSet` and compile and return a `dataframe` of summary statistics for the specified channel each `flowFrame`. This `dataframe` can then be used to visualize the full data set.

```
# load the gate set for BD Accuri C6 cytometer
loadGates(gatesFile = "C6Gates.RData", path = system.file("extdata", package = "flowTime"))
dat_sum <- summarizeFlow(adat, ploidy = "diploid", only = "singlets", channel = "FL1.A")
#> [1] "Gating with diploid singlet gates..."
#> Warning: There was 1 warning in `dplyr::summarise()`.
#> ℹ In argument: `dplyr::across(...)`.
#> Caused by warning:
#> ! Using `across()` without supplying `.cols` was deprecated in dplyr 1.1.0.
#> ℹ Please supply `.cols` instead.

qplot(x = time, y = FL1.Amean, data = dat_sum, linetype = factor(treatment)) + geom_line() +
    xlab("Time post Auxin addition (min)") + ylab("Reporter Fluorescence (AU)") +
    scale_color_discrete(name = expression(paste("Auxin (", mu, "M)", sep = ""))) +
    theme_classic(base_size = 14, base_family = "Arial")
#> Warning: `qplot()` was deprecated in ggplot2 3.4.0.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)