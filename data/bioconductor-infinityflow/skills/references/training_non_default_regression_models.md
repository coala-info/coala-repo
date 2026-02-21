# Training non default regression models

#### Etienne Becht

#### June 2020

# Introduction

This vignette explains how to specify non-default machine learning frameworks and their hyperparameters when applying Infinity Flow. We will assume here that the basic usage of Infinity Flow has already been read, if you are not familiar with this material I suggest you first look at the [basic usage vignette](basic_usage.html)

This vignette will cover:

1. Loading the example data
2. Note on package design
3. The `regression_functions` argument
4. The `extra_args_regression_params` argument
5. Neural networks

# Loading the example data

Here is a single R code chunk that recapitulates all of the data preparation covered in the [basic usage vignette](basic_usage.html).

```
if(!require(devtools)){
    install.packages("devtools")
}
if(!require(infinityFlow)){
    library(devtools)
    install_github("ebecht/infinityFlow")
}
```

```
library(infinityFlow)

data(steady_state_lung)
data(steady_state_lung_annotation)
data(steady_state_lung_backbone_specification)

dir <- file.path(tempdir(), "infinity_flow_example")
input_dir <- file.path(dir, "fcs")
write.flowSet(steady_state_lung, outdir = input_dir)
#> [1] "/tmp/RtmpCfxtW2/infinity_flow_example/fcs"

write.csv(steady_state_lung_backbone_specification, file = file.path(dir, "backbone_selection_file.csv"), row.names = FALSE)

path_to_fcs <- file.path(dir, "fcs")
path_to_output <- file.path(dir, "output")
path_to_intermediary_results <- file.path(dir, "tmp")
backbone_selection_file <- file.path(dir, "backbone_selection_file.csv")

targets <- steady_state_lung_annotation$Infinity_target
names(targets) <- rownames(steady_state_lung_annotation)
isotypes <- steady_state_lung_annotation$Infinity_isotype
names(isotypes) <- rownames(steady_state_lung_annotation)

input_events_downsampling <- 1000
prediction_events_downsampling <- 500
cores = 1L
```

# Note on package design

The `infinity_flow()` function which encapsulates the complete Infinity Flow computational pipeline uses two arguments to respectively select regression models and their hyperparameters. These two arguments are both lists, and should have the same length. The idea is that the first list, `regression_functions` will be a list of model templates (XGBoost, Neural Networks, SVMs…) to train, while the second will be used to specify their hyperparameters. The list of templates is then fit to the data using parallel computing with socketing (using the `parallel` package through the `pbapply` package), which is more memory efficient.

# The `regression_functions` argument

This argument is a list of functions which specifies how many models to train per well and which ones. Each type of machine learning model is supported through a wrapper in the *infinityFlow* package, and has a name of the form `fitter_*`. See below for the complete list:

```
print(grep("fitter_", ls("package:infinityFlow"), value = TRUE))
#> [1] "fitter_glmnet"  "fitter_linear"  "fitter_nn"      "fitter_svm"
#> [5] "fitter_xgboost"
```

| fitter\_ function | Backend | Model type |
| --- | --- | --- |
| fitter\_xgboost | XGBoost | Gradient boosted trees |
| fitter\_nn | Tensorflow/Keras | Neural networks |
| fitter\_svm | e1071 | Support vector machines |
| fitter\_glmnet | glmnet | Generalized linear and polynomial models |
| fitter\_lm | stats | Linear and polynomial models |

These functions rely on optional package dependencies (so that you do not need to install e.g. Keras if you are not planning to use it). We need to make sure that these dependencies are however met:

```
       optional_dependencies <- c("glmnetUtils", "e1071")
       unmet_dependencies <- setdiff(optional_dependencies, rownames(installed.packages()))
       if(length(unmet_dependencies) > 0){
           install.packages(unmet_dependencies)
       }
       for(pkg in optional_dependencies){
           library(pkg, character.only = TRUE)
       }
```

In this vignette we will train all of these models. Note that if you do it on your own data, it make take quite a bit of memory (remember that the output expression matrix will be a numeric matrix of size `(prediction_events_downsampling x number of wells) rows x (number of wells x number of models)`.

To train multiple models we create a list of these fitter\_\* functions and assign this to the `regression_functions` argument that will be fed to the `infinity_flow` function. The names of this list will be used to name your models.

```
regression_functions <- list(
    XGBoost = fitter_xgboost, # XGBoost
    SVM = fitter_svm, # SVM
    LASSO2 = fitter_glmnet, # L1-penalized 2nd degree polynomial model
    LM = fitter_linear # Linear model
)
```

# The `extra_args_regression_params` argument

This argument is a list of list (so of the form `list(list(...), list(...), etc.)`) of length `length(regression_functions)`. Each element of the extra\_args\_regression\_params object is thus a list. This lower-level list will be used to pass named arguments to the machine learning fitting function. The list of `extra_args_regression_params` is matched with the list of machine learning models `regression_functions` using the order of the elements in these two lists (e.g. the first regression model is matched with the first element of the list of arguments, then the seconds elements are matched together, etc…).

```
backbone_size <- table(read.csv(backbone_selection_file)[,"type"])["backbone"]
extra_args_regression_params <- list(
     ## Passed to the first element of `regression_functions`, e.g. XGBoost. See ?xgboost for which parameters can be passed through this list
    list(nrounds = 500, eta = 0.05),

    # ## Passed to the second element of `regression_functions`, e.g. neural networks through keras::fit. See https://keras.rstudio.com/articles/tutorial_basic_regression.html
    # list(
    #         object = { ## Specifies the network's architecture, loss function and optimization method
    #             model = keras_model_sequential()
    #             model %>%
    #                 layer_dense(units = backbone_size, activation = "relu", input_shape = backbone_size) %>%
    #                 layer_dense(units = backbone_size, activation = "relu", input_shape = backbone_size) %>%
    #                 layer_dense(units = 1, activation = "linear")
    #             model %>%
    #                 compile(loss = "mean_squared_error", optimizer = optimizer_sgd(lr = 0.005))
    #             serialize_model(model)
    #         },
    #         epochs = 1000, ## Number of maximum training epochs. The training is however stopped early if the loss on the validation set does not improve for 20 epochs. This early stopping is hardcoded in fitter_nn.
    #         validation_split = 0.2, ## Fraction of the training data used to monitor validation loss
    #         verbose = 0,
    #         batch_size = 128 ## Size of the minibatches for training.
    # ),

    # Passed to the third element, SVMs. See help(svm, "e1071") for possible arguments
    list(type = "nu-regression", cost = 8, nu=0.5, kernel="radial"),

    # Passed to the fourth element, fitter_glmnet. This should contain a mandatory argument `degree` which specifies the degree of the polynomial model (1 for linear, 2 for quadratic etc...). Here we use degree = 2 corresponding to our LASSO2 model Other arguments are passed to getS3method("cv.glmnet", "formula"),
    list(alpha = 1, nfolds=10, degree = 2),

    # Passed to the fourth element, fitter_linear. This only accepts a degree argument specifying the degree of the polynomial model. Here we use degree = 1 corresponding to a linear model.
    list(degree = 1)
)
```

We can now run the pipeline with these custom arguments to train all the models.

```
if(length(regression_functions) != length(extra_args_regression_params)){
    stop("Number of models and number of lists of hyperparameters mismatch")
}
imputed_data <- infinity_flow(
    regression_functions = regression_functions,
    extra_args_regression_params = extra_args_regression_params,
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
#>  15.97033 seconds
#>      SVM
#>
#>  1.024599 seconds
#>      LASSO2
#>
#>  7.360838 seconds
#>      LM
#>
#>  0.07967186 seconds
#> Imputing missing measurements
#>  Randomly drawing events to predict from the test set
#>  Imputing...
#>      XGBoost
#>
#>  0.6234024 seconds
#>      SVM
#>
#>  1.516622 seconds
#>      LASSO2
#>
#>  0.8444324 seconds
#>      LM
#>
#>  0.04356337 seconds
#>  Concatenating predictions
#>  Writing to disk
#> Performing dimensionality reduction
#> 18:25:30 UMAP embedding parameters a = 1.262 b = 1.003
#> 18:25:30 Read 5000 rows and found 17 numeric columns
#> 18:25:30 Using Annoy for neighbor search, n_neighbors = 15
#> 18:25:30 Building Annoy index with metric = euclidean, n_trees = 50
#> 0%   10   20   30   40   50   60   70   80   90   100%
#> [----|----|----|----|----|----|----|----|----|----|
#> **************************************************|
#> 18:25:31 Writing NN index file to temp file /tmp/RtmpCfxtW2/file1916aa4086f55
#> 18:25:31 Searching Annoy index using 1 thread, search_k = 1500
#> 18:25:32 Annoy recall = 100%
#> 18:25:32 Commencing smooth kNN distance calibration using 1 thread with target n_neighbors = 15
#> 18:25:33 Initializing from normalized Laplacian + noise (using RSpectra)
#> 18:25:33 Commencing optimization for 1000 epochs, with 101614 positive edges using 1 thread
#> 18:25:33 Using rng type: pcg
#> 18:25:44 Optimization finished
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

Our model names are appended to the predicted markers in the output. For more discussion about the outputs (including output files written to disk and plots), see the [basic usage vignette](basic_usage.html)

```
   print(imputed_data$bgc[1:2, ])
#>      FSC-A       FSC-H       FSC-W   SSC-A       SSC-H       SSC-W CD69-CD301b
#> 1 52791.90  0.02541834 -0.07531909 4331.57  0.01319484 -0.07704039   0.7655814
#> 3 46171.35 -0.25773514 -0.70827449 1262.42 -1.80480705 -1.04145859   1.2878189
#>      Zombie      MHCII       CD4       CD44        CD8      CD11c      CD11b
#> 1 539.40082 -0.8097174 1.8381101  0.6159337  0.3371221 -2.3673709 0.43102371
#> 3 -16.52464  1.0099491 0.8840223 -1.8477561 -0.3375828 -0.1025223 0.05296512
#>        F480       Ly6C   Lineage  CD45a488 FJComp-PE(yg)-A       CD24
#> 1 -1.135214 -1.2918359 1.5416721 0.7217323       2.0735603 -1.3890068
#> 3 -1.194200 -0.8101826 0.2200733 0.2916668       0.6617211  0.6529279
#>        CD103     Time CD137.LASSO2_bgc CD137.LM_bgc CD137.SVM_bgc
#> 1 -1.0625457 3494.209      -0.08817654   -0.2223966    -1.2697837
#> 3  0.5733102 2575.407       0.20200214   -0.1048126    -0.3701722
#>   CD137.XGBoost_bgc CD28.LASSO2_bgc CD28.LM_bgc CD28.SVM_bgc CD28.XGBoost_bgc
#> 1       -0.68728047       0.2341341   0.3155149    0.3360518        0.3941939
#> 3       -0.05468569      -0.1086096  -0.2182240   -0.3179944       -0.4150262
#>   CD49b(pan-NK).LASSO2_bgc CD49b(pan-NK).LM_bgc CD49b(pan-NK).SVM_bgc
#> 1                0.1237366           -0.2519579          -0.009724207
#> 3               -0.6436806           -0.6050510          -0.614191021
#>   CD49b(pan-NK).XGBoost_bgc KLRG1.LASSO2_bgc KLRG1.LM_bgc KLRG1.SVM_bgc
#> 1                 0.1100776       0.12373433  -0.08737580    -1.0248837
#> 3                -0.6561652       0.01422377  -0.08257832     0.5744309
#>   KLRG1.XGBoost_bgc Ly-49c/F/I/H.LASSO2_bgc Ly-49c/F/I/H.LM_bgc
#> 1        -0.1881977              0.04290248           0.0699577
#> 3        -0.1076525             -0.00266019          -0.1794315
#>   Ly-49c/F/I/H.SVM_bgc Ly-49c/F/I/H.XGBoost_bgc Podoplanin.LASSO2_bgc
#> 1            0.3312898                0.0343672           -0.66624525
#> 3           -0.5545799               -0.4113918            0.05026827
#>   Podoplanin.LM_bgc Podoplanin.SVM_bgc Podoplanin.XGBoost_bgc SHIgG.LASSO2_bgc
#> 1        -0.2165172         -0.7366872             -0.6661237     2.682126e-16
#> 3         0.2656943         -0.1541461             -0.3055354    -9.878614e-16
#>    SHIgG.LM_bgc SHIgG.SVM_bgc SHIgG.XGBoost_bgc SSEA-3.LASSO2_bgc SSEA-3.LM_bgc
#> 1 -1.352101e-16 -5.226283e-16       2.98014e-17         0.2749368    0.09278757
#> 3 -1.155770e-15  2.624180e-16       2.98014e-17        -0.4126442   -0.40649040
#>   SSEA-3.SVM_bgc SSEA-3.XGBoost_bgc TCR Vg3.LASSO2_bgc TCR Vg3.LM_bgc
#> 1     0.02843366          0.4702124         -0.5517869     -0.3732134
#> 3    -1.08985083         -0.4787136         -0.4377855     -0.1131321
#>   TCR Vg3.SVM_bgc TCR Vg3.XGBoost_bgc rIgM.LASSO2_bgc  rIgM.LM_bgc
#> 1       -1.068298          -0.3445941    2.577272e-16 3.780366e-17
#> 3       -1.287720          -0.5149374    1.984829e-15 5.873360e-16
#>    rIgM.SVM_bgc rIgM.XGBoost_bgc    UMAP1    UMAP2 PE_id
#> 1 -3.427161e-16    -1.432124e-16 686.5073 913.5931     1
#> 3  7.563487e-16    -1.432124e-16 952.1279 657.2042     1
```

# Neural networks

Neural networks won’t build in knitr for me but here is an example of the syntax if you want to use them.

Note: there is an issue with serialization of the neural networks and socketing since I updated to R-4.0.1. If you want to use neural networks, please make sure to set

```
cores = 1L
```

```
optional_dependencies <- c("keras", "tensorflow")
unmet_dependencies <- setdiff(optional_dependencies, rownames(installed.packages()))
if(length(unmet_dependencies) > 0){
     install.packages(unmet_dependencies)
}
for(pkg in optional_dependencies){
    library(pkg, character.only = TRUE)
}

invisible(eval(try(keras_model_sequential()))) ## avoids conflicts with flowCore...

if(!is_keras_available()){
     install_keras() ## Instal keras unsing the R interface - can take a while
}

if (!requireNamespace("BiocManager", quietly = TRUE)){
    install.packages("BiocManager")
}
BiocManager::install("infinityFlow")
```

```
library(infinityFlow)
library(keras)

data(steady_state_lung)
data(steady_state_lung_annotation)
data(steady_state_lung_backbone_specification)

dir <- file.path(tempdir(), "infinity_flow_example")
input_dir <- file.path(dir, "fcs")
write.flowSet(steady_state_lung, outdir = input_dir)

write.csv(steady_state_lung_backbone_specification, file = file.path(dir, "backbone_selection_file.csv"), row.names = FALSE)

path_to_fcs <- file.path(dir, "fcs")
path_to_output <- file.path(dir, "output")
path_to_intermediary_results <- file.path(dir, "tmp")
backbone_selection_file <- file.path(dir, "backbone_selection_file.csv")

targets <- steady_state_lung_annotation$Infinity_target
names(targets) <- rownames(steady_state_lung_annotation)
isotypes <- steady_state_lung_annotation$Infinity_isotype
names(isotypes) <- rownames(steady_state_lung_annotation)

input_events_downsampling <- 1000
prediction_events_downsampling <- 500

## Passed to fitter_nn, e.g. neural networks through keras::fit. See https://keras.rstudio.com/articles/tutorial_basic_regression.html
regression_functions <- list(NN = fitter_nn)

backbone_size <- table(read.csv(backbone_selection_file)[,"type"])["backbone"]
extra_args_regression_params <- list(
        list(
        object = { ## Specifies the network's architecture, loss function and optimization method
        model = keras_model_sequential()
        model %>%
        layer_dense(units = backbone_size, activation = "relu", input_shape = backbone_size) %>%
        layer_dense(units = backbone_size, activation = "relu", input_shape = backbone_size) %>%
        layer_dense(units = 1, activation = "linear")
        model %>%
        compile(loss = "mean_squared_error", optimizer = optimizer_sgd(lr = 0.005))
        serialize_model(model)
        },
        epochs = 1000, ## Number of maximum training epochs. The training is however stopped early if the loss on the validation set does not improve for 20 epochs. This early stopping is hardcoded in fitter_nn.
        validation_split = 0.2, ## Fraction of the training data used to monitor validation loss
        verbose = 0,
        batch_size = 128 ## Size of the minibatches for training.
    )
)

imputed_data <- infinity_flow(
    regression_functions = regression_functions,
    extra_args_regression_params = extra_args_regression_params,
    path_to_fcs = path_to_fcs,
    path_to_output = path_to_output,
    path_to_intermediary_results = path_to_intermediary_results,
    backbone_selection_file = backbone_selection_file,
    annotation = targets,
    isotype = isotypes,
    input_events_downsampling = input_events_downsampling,
    prediction_events_downsampling = prediction_events_downsampling,
    verbose = TRUE,
    cores = 1L
)
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
#>  [1] sass_0.4.10         generics_0.1.4      class_7.3-23
#>  [4] gtools_3.9.5        shape_1.4.6.1       lattice_0.22-7
#>  [7] digest_0.6.39       evaluate_1.0.5      grid_4.5.2
#> [10] iterators_1.0.14    fastmap_1.2.0       foreach_1.5.2
#> [13] glmnet_4.1-10       xgboost_3.1.3.1     jsonlite_2.0.0
#> [16] Matrix_1.7-4        RSpectra_0.16-2     e1071_1.7-17
#> [19] survival_3.8-6      pbapply_1.7-4       codetools_0.2-20
#> [22] jquerylib_0.1.4     glmnetUtils_1.1.9   cli_3.6.5
#> [25] rlang_1.1.7         RProtoBufLib_2.22.0 Biobase_2.70.0
#> [28] RcppAnnoy_0.0.23    uwot_0.2.4          matlab_1.0.4.1
#> [31] splines_4.5.2       cachem_1.1.0        yaml_2.3.12
#> [34] otel_0.2.0          cytolib_2.22.0      tools_4.5.2
#> [37] raster_3.6-32       parallel_4.5.2      BiocGenerics_0.56.0
#> [40] R6_2.6.1            png_0.1-8           matrixStats_1.5.0
#> [43] stats4_4.5.2        proxy_0.4-29        lifecycle_1.0.5
#> [46] S4Vectors_0.48.0    terra_1.8-93        bslib_0.9.0
#> [49] data.table_1.18.0   Rcpp_1.1.1          xfun_0.56
#> [52] knitr_1.51          htmltools_0.5.9     rmarkdown_2.30
#> [55] compiler_4.5.2      sp_2.2-0
```