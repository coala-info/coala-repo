# Basic usage of the infinityFlow package

#### Etienne Becht

#### June 2020

# Introduction

Thank you for your interest in the *Infinity Flow* approach. This vignette describes how to apply the package to your massively parallel cytometry (e.g. *LEGENDScreen* or *Lyoplates kits*) experiment. Massively parallel cytometry experiments are cytometry experiments where a sample is aliquoted in *n* subsamples, each stained with a fixed panel of “Backbone” antibodies. Each aliquot is in addition stained with a unique “Infinity” exploratory antibody. The goal of the *infinityFlow* package is to use information from the ubiquitous Backbone staining to predict the expression of sparsely-measured Infinity antibodies across the entire dataset. To learn more about this type of experiments and details about the Infinity Flow approach, please consult [Becht et al, 2020](https://www.biorxiv.org/content/10.1101/2020.06.17.152926v1). In this vignette we achieve this by using the XGBoost machine-learning framework implemented in the [xgboost R package](https://CRAN.R-project.org/package%3Dxgboost). This vignette aims at explaining how to apply a basic *infinityFlow* analysis. Advanced usages, including different machine learning models and custom hyperparameters values, are covered in a [dedicated vignette](training_non_default_regression_models.html).

This vignette will cover:

1. Package installation
2. Setting up your input data
3. Specifying the Backbone and Infinity antibodies
4. Running the Infinity Flow computational pipeline
5. Description of the output

# Package installation

You can install the package from Bioconductor using

```
if (!requireNamespace("BiocManager", quietly = TRUE)){
    install.packages("BiocManager")
}
BiocManager::install("infinityFlow")
```

# Setting up your input data

Now that the package is installed, we load the package and attach its example data. We also load flowCore that will be used to manipulate FCS files in R.

```
library(infinityFlow)
#> Loading required package: flowCore
data(steady_state_lung)
```

The example data is a subset of a massively parallel cytometry experiment of the mouse lung at steady state. The example data contains 10 FCS files. To mimick real world-conditions, we will write this set of FCS files to disk. In this vignette we will use a temporary directory, but you can use the directory of your choice.

```
dir <- file.path(tempdir(), "infinity_flow_example")
print(dir)
#> [1] "/tmp/RtmpCfxtW2/infinity_flow_example"
input_dir <- file.path(dir, "fcs")
write.flowSet(steady_state_lung, outdir = input_dir) ## Omit this if you already have FCS files
#> [1] "/tmp/RtmpCfxtW2/infinity_flow_example/fcs"
list.files(input_dir)
#>  [1] "Plate1_Specimen_001_B12_B12_024.fcs" "Plate1_Specimen_001_D8_D08_044.fcs"
#>  [3] "Plate1_Specimen_001_H11_H11_095.fcs" "Plate3_Specimen_001_A3_A03_003.fcs"
#>  [5] "Plate3_Specimen_001_A9_A09_009.fcs"  "Plate3_Specimen_001_C11_C11_035.fcs"
#>  [7] "Plate3_Specimen_001_C6_C06_030.fcs"  "Plate3_Specimen_001_E5_E05_053.fcs"
#>  [9] "Plate3_Specimen_001_F5_F05_065.fcs"  "Plate3_Specimen_001_G2_G02_074.fcs"
#> [11] "annotation.txt"
```

The second input we have to manually produce is the annotation of the experiment. In the context of a massively parallel cytometry experiment, we need to know what is the protein target of each Infinity (usually PE-conjugated or APC-conjugated) antibody, and what is its isotype. For the example dataset, the annotation is provided in the package and looks like this:

```
data(steady_state_lung_annotation)
print(steady_state_lung_annotation)
#>                                     Infinity_target Infinity_isotype
#> Plate1_Specimen_001_B12_B12_024.fcs            CD28            SHIgG
#> Plate1_Specimen_001_D8_D08_044.fcs    CD49b(pan-NK)             rIgM
#> Plate1_Specimen_001_H11_H11_095.fcs           CD137            SHIgG
#> Plate3_Specimen_001_A3_A03_003.fcs            KLRG1            SHIgG
#> Plate3_Specimen_001_A9_A09_009.fcs     Ly-49c/F/I/H            SHIgG
#> Plate3_Specimen_001_C6_C06_030.fcs       Podoplanin            SHIgG
#> Plate3_Specimen_001_C11_C11_035.fcs          SSEA-3             rIgM
#> Plate3_Specimen_001_E5_E05_053.fcs          TCR Vg3            SHIgG
#> Plate3_Specimen_001_F5_F05_065.fcs            SHIgG            SHIgG
#> Plate3_Specimen_001_G2_G02_074.fcs             rIgM             rIgM
```

The `steady_state_lung_annotation` data.frame contains one line per FCS file, with `rownames(steady_state_lung_annotation) == sampleNames(steady_state_lung)`. The first column specifies the proteins targeted by the Infinity antibody in each FCS file, and the second column specifies its isotype (species and constant region of the antibody). If you load an annotation file from disk, use this command:

```
steady_state_lung_annotation = read.csv("path/to/targets/and/isotypes/annotation/file", row.names = 1, stringsAsFactors = FALSE)
```

That is all we need in terms of inputs! To recap you only need

1. a folder with FCS files from your massively parallel cytometry experiment.
2. a table specifying the antibody targets and antibody isotypes for the Infinity antibodies from your massively parallel cytometry experiment.

# Specifying the Backbone and Infinity antibodies

Now that we have our input data, we need to specify which antibodies are part of the Backbone, and which one is the Infinity antibody. We provide an interactive function to specify this directly in R. This function can be run once, its output saved for future use by downstream functions in the *infinityFlow* package. The `select_backbone_and_exploratory_markers` function will parse an FCS file in the input directory, and for each acquisition channel, ask the user whether it should be used as a predictor (Backbone), exploratory target (Infinity antibodies), or omitted (e.g. Time or Event ID columns…).

```
backbone_specification <- select_backbone_and_exploratory_markers(list.files(input_dir, pattern = ".fcs", full.names = TRUE))
```

Below is an example of the interactive execution of the `select_backbone_and_exploratory_markers` function for the example data. The resulting data.frame is printed too.

```
For each data channel, enter either: backbone, exploratory or discard (can be abbreviated)
FSC-A (FSC-A):discard
FSC-H (FSC-H):backbone
FSC-W (FSC-W):b
SSC-A (SSC-A):d
SSC-H (SSC-H):b
SSC-W (SSC-W):b
CD69-CD301b (FJComp-APC-A):b
Zombie (FJComp-APC-eFlour780-A):b
MHCII (FJComp-Alexa Fluor 700-A):b
CD4 (FJComp-BUV395-A):b
CD44 (FJComp-BUV737-A):b
CD8 (FJComp-BV421-A):b
CD11c (FJComp-BV510-A):b
CD11b (FJComp-BV605-A):b
F480 (FJComp-BV650-A):b
Ly6C (FJComp-BV711-A):b
Lineage (FJComp-BV786-A):b
CD45a488 (FJComp-GFP-A):b
Legend (FJComp-PE(yg)-A):exploratory
CD24 (FJComp-PE-Cy7(yg)-A):b
CD103 (FJComp-PerCP-Cy5-5-A):b
Time (Time):d
                         name        desc        type
$P1                     FSC-A        <NA>     discard
$P2                     FSC-H        <NA>    backbone
$P3                     FSC-W        <NA>    backbone
$P4                     SSC-A        <NA>     discard
$P5                     SSC-H        <NA>    backbone
$P6                     SSC-W        <NA>    backbone
$P7              FJComp-APC-A CD69-CD301b    backbone
$P8    FJComp-APC-eFlour780-A      Zombie    backbone
$P9  FJComp-Alexa Fluor 700-A       MHCII    backbone
$P10          FJComp-BUV395-A         CD4    backbone
$P11          FJComp-BUV737-A        CD44    backbone
$P12           FJComp-BV421-A         CD8    backbone
$P13           FJComp-BV510-A       CD11c    backbone
$P14           FJComp-BV605-A       CD11b    backbone
$P15           FJComp-BV650-A        F480    backbone
$P16           FJComp-BV711-A        Ly6C    backbone
$P17           FJComp-BV786-A     Lineage    backbone
$P18             FJComp-GFP-A    CD45a488    backbone
$P19          FJComp-PE(yg)-A      Legend exploratory
$P20      FJComp-PE-Cy7(yg)-A        CD24    backbone
$P21     FJComp-PerCP-Cy5-5-A       CD103    backbone
$P22                     Time        <NA>     discard
Is selection correct? (yes/no): yes
```

We cannot run this function interactively from this vignette, so we load the result from the package instead:

```
data(steady_state_lung_backbone_specification)
print(head(steady_state_lung_backbone_specification))
#>    name desc     type
#> 1 FSC-A <NA>  discard
#> 2 FSC-H <NA> backbone
#> 3 FSC-W <NA> backbone
#> 4 SSC-A <NA>  discard
#> 5 SSC-H <NA> backbone
#> 6 SSC-W <NA> backbone
```

You need to save this backbone specification file as a CSV file for future use.

```
write.csv(steady_state_lung_backbone_specification, file = file.path(dir, "backbone_selection_file.csv"), row.names = FALSE)
```

# Running the Infinity Flow computational pipeline

Now that we have our input data, FCS files annotation and specification of the Backbone and Infinity antibodies, we have everything we need to run the pipeline.

All the pipeline is packaged into a single function, `infinity_flow()`.

Here is a description of the basic arguments it requires:

1. path\_to\_fcs: path to the folder with input FCS files
2. path\_to\_output: path to a folder where the output will be saved.
3. backbone\_selection\_file: the CSV file specifying backbone and Infinity antibodies, created in the *Specifying the Backbone and Infinity antibodies* section above.
4. annotation: A named vector of Infinity antibody targets per FCS file. We will create it from the annotation table we created in the *Setting up your input data* section
5. isotype: Same as annotation, but specifying Infinity antibody isotypes rather than antibody targets.

We have everything we need in our input folder to fill these arguments:

```
list.files(dir)
#> [1] "backbone_selection_file.csv" "fcs"
```

First, input FCS files:

```
path_to_fcs <- file.path(dir, "fcs")
head(list.files(path_to_fcs, pattern = ".fcs"))
#> [1] "Plate1_Specimen_001_B12_B12_024.fcs" "Plate1_Specimen_001_D8_D08_044.fcs"
#> [3] "Plate1_Specimen_001_H11_H11_095.fcs" "Plate3_Specimen_001_A3_A03_003.fcs"
#> [5] "Plate3_Specimen_001_A9_A09_009.fcs"  "Plate3_Specimen_001_C11_C11_035.fcs"
```

Output directory. It will be created if it doesn’t already exist

```
path_to_output <- file.path(dir, "output")
```

Backbone selection file:

```
list.files(dir)
#> [1] "backbone_selection_file.csv" "fcs"
backbone_selection_file <- file.path(dir, "backbone_selection_file.csv")
head(read.csv(backbone_selection_file))
#>    name desc     type
#> 1 FSC-A <NA>  discard
#> 2 FSC-H <NA> backbone
#> 3 FSC-W <NA> backbone
#> 4 SSC-A <NA>  discard
#> 5 SSC-H <NA> backbone
#> 6 SSC-W <NA> backbone
```

Annotation of Infinity antibody targets and isotypes:

```
targets <- steady_state_lung_annotation$Infinity_target
names(targets) <- rownames(steady_state_lung_annotation)
isotypes <- steady_state_lung_annotation$Infinity_isotype
names(isotypes) <- rownames(steady_state_lung_annotation)
head(targets)
#> Plate1_Specimen_001_B12_B12_024.fcs  Plate1_Specimen_001_D8_D08_044.fcs
#>                              "CD28"                     "CD49b(pan-NK)"
#> Plate1_Specimen_001_H11_H11_095.fcs  Plate3_Specimen_001_A3_A03_003.fcs
#>                             "CD137"                             "KLRG1"
#>  Plate3_Specimen_001_A9_A09_009.fcs  Plate3_Specimen_001_C6_C06_030.fcs
#>                      "Ly-49c/F/I/H"                        "Podoplanin"
head(isotypes)
#> Plate1_Specimen_001_B12_B12_024.fcs  Plate1_Specimen_001_D8_D08_044.fcs
#>                             "SHIgG"                              "rIgM"
#> Plate1_Specimen_001_H11_H11_095.fcs  Plate3_Specimen_001_A3_A03_003.fcs
#>                             "SHIgG"                             "SHIgG"
#>  Plate3_Specimen_001_A9_A09_009.fcs  Plate3_Specimen_001_C6_C06_030.fcs
#>                             "SHIgG"                             "SHIgG"
```

Other arguments are optional, but it is notably worth considering the number of input cells and the number of output cells. This will notably be important if you are using a computer with limited RAM. For the example data it does not matter as we only have access to 2,000 cells per well, but if you run the pipeline on your own data I suggest you start by low values, and ramp up (to 20,000 or 50,000 input cells, and e.g. 10,000 output cells per well) once everything is setup. Another optional argument is `cores` which controls multicore computing, which can speed up execution at the cost of memory usage. In this vignette we use cores = 1, but you probably want to increase this to 4 or 8 or more if your computer can accomodate it.

```
input_events_downsampling <- 1000
prediction_events_downsampling <- 500
cores = 1L
```

There is also an argument to store temporary files, which can be useful to further analyze the data in R. If missing, this argument will default to a temporary directory.

```
path_to_intermediary_results <- file.path(dir, "tmp")
```

At last, now let us execute the pipeline:

```
imputed_data <- infinity_flow(
    path_to_fcs = path_to_fcs,
    path_to_output = path_to_output,
    path_to_intermediary_results = path_to_intermediary_results,
    backbone_selection_file = backbone_selection_file,
    annotation = targets,
    isotype = isotypes,
    input_events_downsampling = input_events_downsampling,
    prediction_events_downsampling = prediction_events_downsampling,
    verbose = TRUE,
    cores = cores
)
#> /tmp/RtmpCfxtW2/infinity_flow_example/tmp and /tmp/RtmpCfxtW2/infinity_flow_example/tmp/subsetted_fcs and /tmp/RtmpCfxtW2/infinity_flow_example/tmp/rds and /tmp/RtmpCfxtW2/infinity_flow_example/output: directories not found, creating directory(ies)
#> Using directories...
#>  input: /tmp/RtmpCfxtW2/infinity_flow_example/fcs
#>  intermediary: /tmp/RtmpCfxtW2/infinity_flow_example/tmp
#>  subset: /tmp/RtmpCfxtW2/infinity_flow_example/tmp/subsetted_fcs
#>  rds: /tmp/RtmpCfxtW2/infinity_flow_example/tmp/rds
#>  annotation: /tmp/RtmpCfxtW2/infinity_flow_example/tmp/annotation.csv
#>  output: /tmp/RtmpCfxtW2/infinity_flow_example/output
#> Parsing and subsampling input data
#>  Downsampling to 1000 events per input file
#>  Concatenating expression matrices
#>  Writing to disk
#> Logicle-transforming the data
#>  Backbone data
#>  Exploratory data
#>  Writing to disk
#>  Transforming expression matrix
#>  Writing to disk
#> Harmonizing backbone data
#>  Scaling expression matrices
#>  Writing to disk
#> Fitting regression models
#>  Randomly selecting 50% of the subsetted input files to fit models
#>  Fitting...
#>      XGBoost
#> Warning in throw_err_or_depr_msg("Passed unrecognized parameters: ",
#> paste(head(names_unrecognized), : Passed unrecognized parameters: verbose. This
#> warning will become an error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'data' has been renamed to 'x'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'label' has been renamed to 'y'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'eta' has been renamed to 'learning_rate'. This warning will
#> become an error in a future version.
#> Warning in throw_err_or_depr_msg("Passed unrecognized parameters: ",
#> paste(head(names_unrecognized), : Passed unrecognized parameters: verbose. This
#> warning will become an error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'data' has been renamed to 'x'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'label' has been renamed to 'y'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'eta' has been renamed to 'learning_rate'. This warning will
#> become an error in a future version.
#> Warning in throw_err_or_depr_msg("Passed unrecognized parameters: ",
#> paste(head(names_unrecognized), : Passed unrecognized parameters: verbose. This
#> warning will become an error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'data' has been renamed to 'x'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'label' has been renamed to 'y'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'eta' has been renamed to 'learning_rate'. This warning will
#> become an error in a future version.
#> Warning in throw_err_or_depr_msg("Passed unrecognized parameters: ",
#> paste(head(names_unrecognized), : Passed unrecognized parameters: verbose. This
#> warning will become an error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'data' has been renamed to 'x'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'label' has been renamed to 'y'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'eta' has been renamed to 'learning_rate'. This warning will
#> become an error in a future version.
#> Warning in throw_err_or_depr_msg("Passed unrecognized parameters: ",
#> paste(head(names_unrecognized), : Passed unrecognized parameters: verbose. This
#> warning will become an error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'data' has been renamed to 'x'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'label' has been renamed to 'y'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'eta' has been renamed to 'learning_rate'. This warning will
#> become an error in a future version.
#> Warning in throw_err_or_depr_msg("Passed unrecognized parameters: ",
#> paste(head(names_unrecognized), : Passed unrecognized parameters: verbose. This
#> warning will become an error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'data' has been renamed to 'x'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'label' has been renamed to 'y'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'eta' has been renamed to 'learning_rate'. This warning will
#> become an error in a future version.
#> Warning in throw_err_or_depr_msg("Passed unrecognized parameters: ",
#> paste(head(names_unrecognized), : Passed unrecognized parameters: verbose. This
#> warning will become an error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'data' has been renamed to 'x'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'label' has been renamed to 'y'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'eta' has been renamed to 'learning_rate'. This warning will
#> become an error in a future version.
#> Warning in throw_err_or_depr_msg("Passed unrecognized parameters: ",
#> paste(head(names_unrecognized), : Passed unrecognized parameters: verbose. This
#> warning will become an error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'data' has been renamed to 'x'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'label' has been renamed to 'y'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'eta' has been renamed to 'learning_rate'. This warning will
#> become an error in a future version.
#> Warning in throw_err_or_depr_msg("Passed unrecognized parameters: ",
#> paste(head(names_unrecognized), : Passed unrecognized parameters: verbose. This
#> warning will become an error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'data' has been renamed to 'x'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'label' has been renamed to 'y'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'eta' has been renamed to 'learning_rate'. This warning will
#> become an error in a future version.
#> Warning in throw_err_or_depr_msg("Passed unrecognized parameters: ",
#> paste(head(names_unrecognized), : Passed unrecognized parameters: verbose. This
#> warning will become an error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'data' has been renamed to 'x'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'label' has been renamed to 'y'. This warning will become an
#> error in a future version.
#> Warning in throw_err_or_depr_msg("Parameter '", match_old, "' has been renamed
#> to '", : Parameter 'eta' has been renamed to 'learning_rate'. This warning will
#> become an error in a future version.
#>  15.93178 seconds
#> Imputing missing measurements
#>  Randomly drawing events to predict from the test set
#>  Imputing...
#>      XGBoost
#>
#>  0.6362195 seconds
#>  Concatenating predictions
#>  Writing to disk
#> Performing dimensionality reduction
#> 18:24:02 UMAP embedding parameters a = 1.262 b = 1.003
#> 18:24:02 Read 5000 rows and found 17 numeric columns
#> 18:24:02 Using Annoy for neighbor search, n_neighbors = 15
#> 18:24:03 Building Annoy index with metric = euclidean, n_trees = 50
#> 0%   10   20   30   40   50   60   70   80   90   100%
#> [----|----|----|----|----|----|----|----|----|----|
#> **************************************************|
#> 18:24:03 Writing NN index file to temp file /tmp/RtmpCfxtW2/file1916aa584491b0
#> 18:24:03 Searching Annoy index using 1 thread, search_k = 1500
#> 18:24:04 Annoy recall = 100%
#> 18:24:05 Commencing smooth kNN distance calibration using 1 thread with target n_neighbors = 15
#> 18:24:06 Initializing from normalized Laplacian + noise (using RSpectra)
#> 18:24:06 Commencing optimization for 1000 epochs, with 102236 positive edges using 1 thread
#> 18:24:06 Using rng type: pcg
#> 18:24:16 Optimization finished
#> Exporting results
#>  Transforming predictions back to a linear scale
#>  Exporting FCS files (1 per well)
#> Plotting
#>  Chopping off the top and bottom 0.005 quantiles
#>  Shuffling the order of cells (rows)
#>  Producing plot
#> Background correcting
#>  Transforming background-corrected predictions. (Use logarithm to visualize)
#>  Exporting FCS files (1 per well)
#> Plotting
#>  Chopping off the top and bottom 0.005 quantiles
#>  Shuffling the order of cells (rows)
#>  Producing plot
```

The above command populated our output directory with new sets of files which we describe in the next section.

# Description of the output

The output mainly consists of

1. Sets of FCS files with imputed data, which can be used for further downstream analysis.
2. PDFs of a UMAP embedding of the Backbone data, color-coded by imputed expression of the Infinity antibody

Each of the above comes in two flavours, either **raw** or **background-corrected**.

At the end of the pipeline, input FCS files are augmented with imputed data. Feel free to explore these files in whatever flow cytometry software you are comfortable with! They should look pretty much like regular FCS files, although they are computationnally derived. You can find the output FCS files in the `path_to_output` directory, specifically:

```
head(list.files(path_to_fcs)) ## Input files
#> [1] "Plate1_Specimen_001_B12_B12_024.fcs" "Plate1_Specimen_001_D8_D08_044.fcs"
#> [3] "Plate1_Specimen_001_H11_H11_095.fcs" "Plate3_Specimen_001_A3_A03_003.fcs"
#> [5] "Plate3_Specimen_001_A9_A09_009.fcs"  "Plate3_Specimen_001_C11_C11_035.fcs"
fcs_raw <- file.path(path_to_output, "FCS", "split")
head(list.files(fcs_raw)) ## Raw output FCS files
#> [1] "Plate1_Specimen_001_B12_B12_024_target_CD28.fcs"
#> [2] "Plate1_Specimen_001_D8_D08_044_target_CD49b(pan-NK).fcs"
#> [3] "Plate1_Specimen_001_H11_H11_095_target_CD137.fcs"
#> [4] "Plate3_Specimen_001_A3_A03_003_target_KLRG1.fcs"
#> [5] "Plate3_Specimen_001_A9_A09_009_target_Ly-49c-F-I-H.fcs"
#> [6] "Plate3_Specimen_001_C11_C11_035_target_SSEA-3.fcs"
fcs_bgc <- file.path(path_to_output, "FCS_background_corrected", "split") ## Background-corrected output FCS files
head(list.files(fcs_bgc)) ## Background-corrected output FCS files
#> [1] "Plate1_Specimen_001_B12_B12_024_target_CD28.fcs"
#> [2] "Plate1_Specimen_001_D8_D08_044_target_CD49b(pan-NK).fcs"
#> [3] "Plate1_Specimen_001_H11_H11_095_target_CD137.fcs"
#> [4] "Plate3_Specimen_001_A3_A03_003_target_KLRG1.fcs"
#> [5] "Plate3_Specimen_001_A9_A09_009_target_Ly-49c-F-I-H.fcs"
#> [6] "Plate3_Specimen_001_C11_C11_035_target_SSEA-3.fcs"
```

Finally, the pipeline produces two PDF files, with a UMAP embedding of the backbone data color-coded by the imputed data. This is a very informative output and a good way to start analyzing your data. These files are present in the `path_to_output` directory. The example dataset is very small but feel free to look at the result for illustration purposes. This PDF is available at

```
file.path(path_to_output, "umap_plot_annotated.pdf") ## Raw plot
#> [1] "/tmp/RtmpCfxtW2/infinity_flow_example/output/umap_plot_annotated.pdf"
file.path(path_to_output, "umap_plot_annotated_backgroundcorrected.pdf") ## Background-corrected plot
#> [1] "/tmp/RtmpCfxtW2/infinity_flow_example/output/umap_plot_annotated_backgroundcorrected.pdf"
```

# Conclusion

Thank you for following this vignette, I hope you made it through the end without too much headache and that it was informative. General questions about proper usage of the package are best asked on the [Bioconductor support site](https://support.bioconductor.org/) to maximize visibility for future users. If you encounter bugs, feel free to raise an issue on infinityFlow’s [github](https://github.com/ebecht/infinityFlow/issues).

# Information about the R session when this vignette was built

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> Random number generation:
#>  RNG:     L'Ecuyer-CMRG
#>  Normal:  Inversion
#>  Sample:  Rejection
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] infinityFlow_1.20.2 flowCore_2.22.1
#>
#> loaded via a namespace (and not attached):
#>  [1] Matrix_1.7-4        jsonlite_2.0.0      compiler_4.5.2
#>  [4] Rcpp_1.1.1          Biobase_2.70.0      cytolib_2.22.0
#>  [7] matlab_1.0.4.1      parallel_4.5.2      jquerylib_0.1.4
#> [10] png_0.1-8           uwot_0.2.4          yaml_2.3.12
#> [13] fastmap_1.2.0       lattice_0.22-7      R6_2.6.1
#> [16] RProtoBufLib_2.22.0 generics_0.1.4      knitr_1.51
#> [19] BiocGenerics_0.56.0 bslib_0.9.0         rlang_1.1.7
#> [22] sp_2.2-0            cachem_1.1.0        terra_1.8-93
#> [25] xfun_0.56           sass_0.4.10         otel_0.2.0
#> [28] cli_3.6.5           digest_0.6.39       grid_4.5.2
#> [31] pbapply_1.7-4       xgboost_3.1.3.1     lifecycle_1.0.5
#> [34] S4Vectors_0.48.0    RSpectra_0.16-2     data.table_1.18.0
#> [37] evaluate_1.0.5      raster_3.6-32       codetools_0.2-20
#> [40] stats4_4.5.2        RcppAnnoy_0.0.23    rmarkdown_2.30
#> [43] matrixStats_1.5.0   tools_4.5.2         htmltools_0.5.9
```