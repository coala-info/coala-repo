# scpred-cli CWL Generation Report

## scpred-cli_scpred_get_feature_space.R

### Tool Description
Get the feature space for scPred

### Metadata
- **Docker Image**: quay.io/biocontainers/scpred-cli:0.1.0--hdfd78af_2
- **Homepage**: https://github.com/ebi-gene-expression-group/scPred-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scpred-cli/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scpred-cli/overview
- **Total Downloads**: 26.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ebi-gene-expression-group/scPred-cli
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/scpred_get_feature_space.R [options]


Options:
	-i INPUT-OBJECT, --input-object=INPUT-OBJECT
		Path to the input object of Seurat class in .rds format

	-p PREDICTION-COLUMN, --prediction-column=PREDICTION-COLUMN
		Name of the metadata column that contains cell labels

	-c CORRECTION-METHOD, --correction-method=CORRECTION-METHOD
		Multiple testing correction method. Default: fdr

	-s SIGNIFICANCE-THRESHOLD, --significance-threshold=SIGNIFICANCE-THRESHOLD
		Significance threshold for principal components explaining class identity

	-r REDUCTION-PARAMETER, --reduction-parameter=REDUCTION-PARAMETER
		Name of reduction in Seurat objet to be used to determine the feature space. Default: "pca"

	-o OUTPUT-PATH, --output-path=OUTPUT-PATH
		Path for the modified scPred object in .rds format

	-h, --help
		Show this help message and exit
```


## scpred-cli_scpred_train_model.R

### Tool Description
Trains a cell type classifier using scPred.

### Metadata
- **Docker Image**: quay.io/biocontainers/scpred-cli:0.1.0--hdfd78af_2
- **Homepage**: https://github.com/ebi-gene-expression-group/scPred-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scpred-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scpred_train_model.R [options]


Options:
	-i INPUT-OBJECT, --input-object=INPUT-OBJECT
		Path to the input object of Seurat class in .rds format

	-f TRAIN-ID, --train-id=TRAIN-ID
		ID of the training dataset (optional)

	-m MODEL, --model=MODEL
		Model type used for training. Must be one of the models supported by Caret package. 
                Default: svmRadial

	-r RESAMPLE-METHOD, --resample-method=RESAMPLE-METHOD
		Resampling method used for model fit evaluation

	-n ITER-NUM, --iter-num=ITER-NUM
		Number of resampling iterations. Default: 5

	-s RANDOM-SEED, --random-seed=RANDOM-SEED
		Random seed

	-p ALLOW-PARALLEL, --allow-parallel=ALLOW-PARALLEL
		Should parallel processing be allowed? Default: TRUE

	-c NUM-CORES, --num-cores=NUM-CORES
		For parallel processing, how many cores should be used?

	-t TUNE-LENGTH, --tune-length=TUNE-LENGTH
		An integer denoting the amount of granularity in the tuning parameter grid

	-a METRIC, --metric=METRIC
		Performance metric to be used to select best model

	-e PREPROCESS, --preprocess=PREPROCESS
		A string vector that defines a pre-processing of the predictor data. Enter values as comma-separated string. Current possibilities are 
                'BoxCox', 'YeoJohnson', 'expoTrans', 'center', 'scale', 'range', 'knnImpute', 'bagImpute', 'medianImpute' 
                'pca', 'ica' and 'spatialSign'. The default is 'center' and 'scale'.

	-u RETURN-DATA, --return-data=RETURN-DATA
		If TRUE, training data is returned within scPred object. Default: FALSE

	-v SAVE-PREDICTIONS, --save-predictions=SAVE-PREDICTIONS
		Specifies the set of hold-out predictions for each resample that should be
                returned. Values can be either 'all', 'final' or 'none'.

	-y RECLASSIFY, --reclassify=RECLASSIFY
		Cell types to reclassify using a different model

	-o OUTPUT-PATH, --output-path=OUTPUT-PATH
		Path for the output scPred object in .rds format

	-g GET-SCPRED, --get-scpred=GET-SCPRED
		Should scpred object be extracted from Seurat object after model training? Default: FALSE

	-d TRAIN-PROBS-PLOT, --train-probs-plot=TRAIN-PROBS-PLOT
		Path for training probabilities plot in .png format

	-h, --help
		Show this help message and exit
```


## scpred-cli_scpred_predict.R

### Tool Description
Predicts cell types using scPred.

### Metadata
- **Docker Image**: quay.io/biocontainers/scpred-cli:0.1.0--hdfd78af_2
- **Homepage**: https://github.com/ebi-gene-expression-group/scPred-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scpred-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scpred_predict.R [options]


Options:
	-i INPUT-OBJECT, --input-object=INPUT-OBJECT
		Path to the input object of scPred or seurat class in .rds format

	-p PRED-DATA, --pred-data=PRED-DATA
		Path to the input prediction matrix in .rds format

	-n NORMALISE-DATA, --normalise-data=NORMALISE-DATA
		Should the predicted expression data be normalised? Default: False

	-m NORMALISATION-METHOD, --normalisation-method=NORMALISATION-METHOD
		If --normalise-data specified, what normalisation method to use? Default: LogNormalize
                NB: normalisation method must be identical to that used for reference data

	-s SCALE-FACTOR, --scale-factor=SCALE-FACTOR
		If --normalise-data specified, what scale factor should be applied? 
                Note: for CPM normalisation, select 1e6

	-l THRESHOLD-LEVEL, --threshold-level=THRESHOLD-LEVEL
		Classification threshold value

	-x MAX-ITER-HARMONY, --max-iter-harmony=MAX-ITER-HARMONY
		Maximum number of rounds to run Harmony. One round of Harmony involves one clustering and one correction step

	-r RECOMPUTE-ALIGNMENT, --recompute-alignment=RECOMPUTE-ALIGNMENT
		Recompute alignment? Useful if scPredict() has already been run. Default: TRUE

	-k REFERENCE-SCALING, --reference-scaling=REFERENCE-SCALING
		Scale new dataset based on means and stdevs from reference dataset before alignment. Default: TRUE

	-e RANDOM-SEED, --random-seed=RANDOM-SEED
		Random number generator seed

	-o OUTPUT-PATH, --output-path=OUTPUT-PATH
		Output path for Seurat object holding predicted values

	-a PLOT-PATH, --plot-path=PLOT-PATH
		Output path for prediction probabilities histograms in .png format

	-h, --help
		Show this help message and exit
```


## scpred-cli_scpred_get_std_output.R

### Tool Description
Get standard output from SCPRED predictions.

### Metadata
- **Docker Image**: quay.io/biocontainers/scpred-cli:0.1.0--hdfd78af_2
- **Homepage**: https://github.com/ebi-gene-expression-group/scPred-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scpred-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scpred_get_std_output.R [options]


Options:
	-i PREDICTIONS-OBJECT, --predictions-object=PREDICTIONS-OBJECT
		Path to the Seurat predictions object in .rds format

	-s, --get-scores
		Should score column be added? Default: TRUE

	-k CLASSIFIER, --classifier=CLASSIFIER
		Path to the classifier object in .rds format (Optional; required to add dataset of origin to output table)

	-o OUTPUT-TABLE, --output-table=OUTPUT-TABLE
		Path to the final output file in text format

	-h, --help
		Show this help message and exit
```


## Metadata
- **Skill**: generated
