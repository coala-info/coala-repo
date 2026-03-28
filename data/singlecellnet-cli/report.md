# singlecellnet-cli CWL Generation Report

## singlecellnet-cli_scn-train-model.R

### Tool Description
Train a single cell classifier model.

### Metadata
- **Docker Image**: quay.io/biocontainers/singlecellnet-cli:0.0.1--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/singlecellnet-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/singlecellnet-cli/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/singlecellnet-cli/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ebi-gene-expression-group/singlecellnet-cli
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/scn-train-model.R [options]


Options:
	-i INPUT-OBJECT, --input-object=INPUT-OBJECT
		Path to the input object with training data. SCE class in .rds format.

	-c CELL-TYPE-COL, --cell-type-col=CELL-TYPE-COL
		Name of the cell type annotation column in object metadata.

	-b CELL-BARCODE-COL, --cell-barcode-col=CELL-BARCODE-COL
		Name of the barcode column in object metadata.

	-n N-TOP-GENES, --n-top-genes=N-TOP-GENES
		The number of classification genes per category.

	-p N-TOP-GENE-PAIRS, --n-top-gene-pairs=N-TOP-GENE-PAIRS
		The number of top gene pairs per category.

	-r N-RAND, --n-rand=N-RAND
		Number of random profiles to generate for training.

	-t N-TREES, --n-trees=N-TREES
		Number of trees for random forest classifier

	-s, --stratify
		Should the 'stratify' parameter be set?

	-e WEIGHTED-DOWN-THRESHOLD, --weighted-down-threshold=WEIGHTED-DOWN-THRESHOLD
		The threshold at which anything lower than that is 0 for weighted_down function

	-f TRANSPROP-FACTOR, --transprop-factor=TRANSPROP-FACTOR
		Scaling factor for transprop.

	-w WEIGHTED-DOWN-TOTAL, --weighted-down-total=WEIGHTED-DOWN-TOTAL
		Numeric post transformation sum of read counts for weighted_down function

	-d DATASET-ID, --dataset-id=DATASET-ID
		Name of the dataset used for training the classifier.

	-o OUTPUT-PATH, --output-path=OUTPUT-PATH
		Output path for the trained classifier.

	-h, --help
		Show this help message and exit
```


## singlecellnet-cli_scn-predict.R

### Tool Description
Predict cell types using a trained classifier.

### Metadata
- **Docker Image**: quay.io/biocontainers/singlecellnet-cli:0.0.1--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/singlecellnet-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/singlecellnet-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scn-predict.R [options]


Options:
	-i INPUT-CLASSIFIER-OBJECT, --input-classifier-object=INPUT-CLASSIFIER-OBJECT
		Path to the input classifier object in .rds format.

	-q QUERY-EXPRESSION-DATA, --query-expression-data=QUERY-EXPRESSION-DATA
		Path to the SCE object containing expression data to be predicted.

	-n N-RAND-PROF, --n-rand-prof=N-RAND-PROF
		The number of random profiles generated for evaluation process

	-o PREDICTION-OUTPUT, --prediction-output=PREDICTION-OUTPUT
		Output path to the predictions obtained from the classifier.

	-r, --return-raw-output
		Should the output be returned in raw format (i.e. not transformed into table)? Default: FALSE.

	-h, --help
		Show this help message and exit
```


## Metadata
- **Skill**: generated
