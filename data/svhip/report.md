# svhip CWL Generation Report

## svhip_data

### Tool Description
Processes input data for svhip, potentially generating control datasets and optimizing alignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
- **Homepage**: https://github.com/chrisBioInf/Svhip
- **Package**: https://anaconda.org/channels/bioconda/packages/svhip/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svhip/overview
- **Total Downloads**: 13.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chrisBioInf/Svhip
- **Stars**: N/A
### Original Help Text
```text
Usage: 
svhip.py  [options]

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i IN_FILE, --input=IN_FILE
                        The input directory or file (Required).
  -o OUT_FILE, --outfile=OUT_FILE
                        Name for the output directory (Required).
  -N NEGATIVE, --negative=NEGATIVE
                        Should a specific negative data set be supplied for
                        data generation? If this field is EMPTY it will be
                        auto-generated based on the data at hand (This will be
                        the desired option for most uses).
  -d MAX_ID, --max-id=MAX_ID
                        During data preprocessing, sequences above identity
                        threshold (in percent) will be removed. Default: 95.
  -n N_SEQS, --num-sequences=N_SEQS
                        Number of sequences input alignments will be optimized
                        towards. Default: 100.
  -l WINDOW_LENGTH, --window-length=WINDOW_LENGTH
                        Length of overlapping windows that alignments will be
                        sliced into. Default: 120.
  -s SLIDE, --slide=SLIDE
                        Controls the step size during alignment slicing and
                        thereby the overlap of each window.
  -w N_WINDOWS, --windows=N_WINDOWS
                        The number of times the alignment should be fully
                        sliced in windows - for variation.
  -g GENERATE_CONTROL, --generate-control=GENERATE_CONTROL
                        Flag to determine if a negative set should be auto-
                        generated (Default: False).
  -c SHUFFLE_CONTROL, --shuffle-control=SHUFFLE_CONTROL
                        Use the column-based shuffling approach provided by
                        the RNAz framework instead of SISSIz (Default: False).
  -p POS_LABEL, --positive-label=POS_LABEL
                        The label that should be assigned to the feature
                        vectors generated from the (non-control) input data.
                        Can be CDS (for protein coding sequences) or ncRNA.
                        (Default: ncRNA).
  -H HEXAMER_MODEL, --hexamer-model=HEXAMER_MODEL
                        The Location of the statistical Hexamer model to use.
                        An example file is included with the download as
                        Human_hexamer.tsv, which will be used as a fallback.
  -S STRUCTURE_FILTER, --no-structural-filter=STRUCTURE_FILTER
                        Set this flag to True if no filtering of alignment
                        windows for statistical significance of structure
                        should occur (Default: False).
  -T TREE_PATH, --tree=TREE_PATH
                        If an evolutionary tree of species in the alignment is
                        available in Newick format, you can pass it here.
                        Names have to be identical. If None is passed, one
                        will be estimated based on sequences at hand.
Input path is missing. Supply it with -i, --input.
```


## svhip_training

### Tool Description
svhip.py

### Metadata
- **Docker Image**: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
- **Homepage**: https://github.com/chrisBioInf/Svhip
- **Package**: https://anaconda.org/channels/bioconda/packages/svhip/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
svhip.py  [options]

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i IN_FILE, --input=IN_FILE
                        The input directory or file (Required).
  -o OUT_FILE, --outfile=OUT_FILE
                        Name for the output directory (Required).
  -S STRUCTURE, --structure=STRUCTURE
                        Flag determining if only secondary structure
                        conservation features should be considered. If True,
                        protein coding features will be included (Default:
                        False).
  -M ML, --model=ML     The model type to be trained. You can choose LR
                        (Logistic regression), SVM (Support vector machine) or
                        RF (Random Forest). (Default: SVM)
  --optimize-hyperparameters=OPTIMIZE
                        Select if a parameter optimization should be performed
                        for the ML model. Default is on.
  --optimizer=OPTIMIZER
                        Select the optimizer for hyperparameter search. Search
                        will be conducted with 5-fold crossvalidation and
                        either of 'gridsearch' (default, more precise) or
                        'randomwalk' (faster).
  --low-c=LOW_C         SVM hyperparameter search: Lowest value of the cost
                        (C) parameter to optimize. Does nothing if no SVM
                        classifier is used.
  --high-c=HIGH_C       SVM hyperparameter search: Highest value of the cost
                        (C) parameter to optimize. Does nothing if no SVM
                        classifier is used.
  --low-gamma=LOW_G     SVM hyperparameter search: Lowest value of the gamma
                        parameter to optimize. Does nothing if no SVM
                        classifier is used.
  --high-gamma=HIGH_G   SVM hyperparameter search: Highest value of the gamma
                        parameter to optimize. Does nothing if no SVM
                        classifier is used.
  --hyperparameter-steps=GRID_STEPS
                        Number of values to try out for EACH hyperparameter.
                        Values will be evenly spaced. Default: 10
  --logscale=LOGSCALE   Flag that decides if a logarithmic scale should be
                        used for the hyperparameter grid. If set, a log base
                        can be set with --logbase.
  --logbase=LOGBASE     The logarithmic base if a log scale is used in
                        hyperparameter search. Default: 10.
  --min-trees=LOW_ESTIMATORS
                        Random Forest hyperparameter search: Minimum number of
                        trees before optimization. Does nothing if no RF
                        classifier is used.
  --max-trees=HIGH_ESTIMATORS
                        Random hyperparameter search: Maximum number of trees
                        before optimization. Does nothing if no RF classifier
                        is used.
  --min-samples-split=LOW_SPLIT
                        Random Forest hyperparameter search: Minimum number of
                        samples for splitting an internal node in the forest.
                        Does nothing if no RF classifier is used.
  --max-samples-split=HIGH_SPLIT
                        Random hyperparameter search:  Maximum number of
                        samples for splitting an internal node in the forest.
                        Does nothing if no RF classifier is used.
  --min-samples-leaf=LOW_LEAF
                        Random Forest hyperparameter search: Minimum number of
                        samples for splitting a leaf node in the forest. Does
                        nothing if no RF classifier is used.
  --max-samples-leaf=HIGH_LEAF
                        Random hyperparameter search: Maximum number of
                        samples for splitting a leaf node in the forest. Does
                        nothing if no RF classifier is used.
Input path is missing. Supply it with -i, --input.
```


## svhip_evaluate

### Tool Description
Evaluate SVHIP models or make predictions.

### Metadata
- **Docker Image**: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
- **Homepage**: https://github.com/chrisBioInf/Svhip
- **Package**: https://anaconda.org/channels/bioconda/packages/svhip/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
svhip.py  [options]

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i IN_FILE, --input=IN_FILE
                        The input directory or file (Required).
  -o OUT_FILE, --outfile=OUT_FILE
                        Name for the output directory (Required).
  --model-path=MODEL_PATH
                        If running a model test (--task test) or prediction
                        (--task predict), this is the path of the model to
                        evaluate. The data set to use should be handed over
                        with -i, --input.
```


## svhip_features

### Tool Description
Calculate features for SVHIP.

### Metadata
- **Docker Image**: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
- **Homepage**: https://github.com/chrisBioInf/Svhip
- **Package**: https://anaconda.org/channels/bioconda/packages/svhip/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
svhip.py  [options]

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i IN_FILE, --input=IN_FILE
                        The input directory or file (Required).
  -o OUT_FILE, --outfile=OUT_FILE
                        Name for the output file. Optional here, as features
                        can also be printed to stdout.
  -R REVERSE, --reverse=REVERSE
                        Also scan the reverse complement when calculating
                        features.
  -H HEXAMER_MODEL, --hexamer-model=HEXAMER_MODEL
                        The Location of the statistical Hexamer model to use.
                        An example file is included with the download as
                        Human_hexamer.tsv, which will be used as a fallback.
  -T TREE_PATH, --tree=TREE_PATH
                        If an evolutionary tree of species in the alignment is
                        available in Newick format, you can pass it here.
                        Names have to be identical. If None is passed, one
                        will be estimated based on sequences at hand.
  --stdout=STDOUT       Set the --stdout flag to False if you do not want to
                        have output printed to screen as well. This feature is
                        mostly for manual redirection to files.
```


## svhip_predict

### Tool Description
Predicts structural variations using a trained model.

### Metadata
- **Docker Image**: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
- **Homepage**: https://github.com/chrisBioInf/Svhip
- **Package**: https://anaconda.org/channels/bioconda/packages/svhip/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
svhip.py  [options]

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i IN_FILE, --input=IN_FILE
                        The input directory or file (Required).
  -o OUT_FILE, --outfile=OUT_FILE
                        Name for the output directory (Required).
  -M MODEL_PATH, --model-path=MODEL_PATH
                        If running a model test (--task test) or prediction
                        (--task predict), this is the path of the model to
                        evaluate. The data set to use should be handed over
                        with -i, --input.
  --column-label=PREDICTION_LABEL
                        Column name for the prediction in the output.
  --structure=NCRNA     Set to True if only features for conservation of
                        secondary structure should be used. Depends on type of
                        model.
  --gtf=GTF             Set to True if you want overlapping annotations to be
                        merged and written as GTF file. IMPORTANT: Requires
                        genomic coordinates in input.
  --probability=PROBABILITY
                        Set to True if you want class probabilities assigned
                        in final output. Warning: Requires model to be trained
                        with probability flag.
Input path is missing. Supply it with -i, --input.
```


## svhip_codon_conservation

### Tool Description
Calculates codon conservation scores for SVHIP analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
- **Homepage**: https://github.com/chrisBioInf/Svhip
- **Package**: https://anaconda.org/channels/bioconda/packages/svhip/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
svhip.py  [options]

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i IN_FILE, --input=IN_FILE
                        The input directory or file (Required).
  -o OUT_FILE, --outfile=OUT_FILE
                        Name for the output directory (Required).
Input path is missing. Supply it with -i, --input.
```


## svhip_combine

### Tool Description
Combine feature vectors from multiple files.

### Metadata
- **Docker Image**: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
- **Homepage**: https://github.com/chrisBioInf/Svhip
- **Package**: https://anaconda.org/channels/bioconda/packages/svhip/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
svhip.py  [options]

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i IN_FILE, --input=IN_FILE
                        The input directory or file (Required).
  -o OUT_FILE, --outfile=OUT_FILE
                        Name for the output directory (Required).
  -p PREFIX, --prefix=PREFIX
                        Prefix for selection of files to combine. For example,
                        if set to TEST, only valid feature vector containing
                        files with the prefix TEST will be added.
Output path is missing. Supply it with -o, --output.
```


## svhip_hexcalibrate

### Tool Description
Options:

### Metadata
- **Docker Image**: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
- **Homepage**: https://github.com/chrisBioInf/Svhip
- **Package**: https://anaconda.org/channels/bioconda/packages/svhip/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
svhip.py  [options]

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -c IN_CODING, --coding=IN_CODING
                        Should point towards a Fasta-file of coding
                        transcripts (transcripts HAVE to be in-frame).
  -n IN_NONCODING, --noncoding=IN_NONCODING
                        Fasta-file with transcripts or sequences that are NOT
                        coding.
  -o OUT_FILE, --outfile=OUT_FILE
                        Name or path of the file to write. Will be a tab-
                        delimited text file (.tsv).
```


## svhip_index

### Tool Description
Index SVHIP data

### Metadata
- **Docker Image**: quay.io/biocontainers/svhip:1.0.9--hdfd78af_0
- **Homepage**: https://github.com/chrisBioInf/Svhip
- **Package**: https://anaconda.org/channels/bioconda/packages/svhip/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: 
svhip.py  [options]

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -i IN_FILE, --input=IN_FILE
                        The input directory or file (Required).
Input path is missing. Supply it with -i, --input.
```

