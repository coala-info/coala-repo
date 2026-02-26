# cherri CWL Generation Report

## cherri_eval

### Tool Description
Evaluate RRIs using a trained model.

### Metadata
- **Docker Image**: quay.io/biocontainers/cherri:0.8--pyh7cba7a3_0
- **Homepage**: https://github.com/BackofenLab/Cherri
- **Package**: https://anaconda.org/channels/bioconda/packages/cherri/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cherri/overview
- **Total Downloads**: 5.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BackofenLab/Cherri
- **Stars**: N/A
### Original Help Text
```text
usage: cherri eval [-h] -i1 RRIS_TABLE -g GENOME -o OUT_PATH -l CHROM_LEN_FILE
                   [-m MODEL_FILE] [-mp MODEL_PARAMS] [-i2 OCCUPIED_REGIONS]
                   [-c [CONTEXT]] [-n EXPERIMENT_NAME] [-p PARAM_FILE]
                   [-st USE_STRUCTURE] [-on OUT_NAME] [-ef EVAL_FEATURES]
                   [-j N_JOBS]

optional arguments:
  -h, --help            show this help message and exit
  -i2 OCCUPIED_REGIONS, --occupied_regions OCCUPIED_REGIONS
                        Path to occupied regions python object file containing
                        a dictionary
  -c [CONTEXT], --context [CONTEXT]
                        How much context should be added at up- and downstream
                        of the sequence. Default: 150
  -n EXPERIMENT_NAME, --experiment_name EXPERIMENT_NAME
                        Name of the data source of the RRIs, e.g. experiment
                        and organism. Default: eval_rri
  -p PARAM_FILE, --param_file PARAM_FILE
                        IntaRNA parameter file. Default: file in
                        path_to_cherri_folder/Cherri/rrieval/IntaRNA_param
  -st USE_STRUCTURE, --use_structure USE_STRUCTURE
                        Set 'off' if you want to disable structure. Default
                        'on'
  -on OUT_NAME, --out_name OUT_NAME
                        Name for the output directory. Default:
                        'date_Cherri_evaluating_RRIs'
  -ef EVAL_FEATURES, --eval_features EVAL_FEATURES
                        If you want to start from hand-curated feature files.
                        Use this for evaluating test set performance (set
                        'on'). Default: 'off'
  -j N_JOBS, --n_jobs N_JOBS
                        Number of jobs used for graph feature computation.
                        Default: 1

required arguments:
  -i1 RRIS_TABLE, --RRIs_table RRIS_TABLE
                        Table containing all RRIs that should be evaluated in
                        the correct format
  -g GENOME, --genome GENOME
                        Path to genome FASTA file, or use the built-in
                        download function if you want the human or mouse
                        genome
  -o OUT_PATH, --out_path OUT_PATH
                        Path to output directory where the output folder will
                        be stored. It will contain separate output folders for
                        each step of the data and feature preparation as well
                        as the evaluated instances
  -l CHROM_LEN_FILE, --chrom_len_file CHROM_LEN_FILE
                        Tabular file containing data in two-column format for
                        each chromosome: 'chrom name' 'chrom length'. You can
                        directly specify 'human' or 'mouse'
  -m MODEL_FILE, --model_file MODEL_FILE
                        Set path to the model which should be used for
                        evaluation
  -mp MODEL_PARAMS, --model_params MODEL_PARAMS
                        Set path to the feature file of the given model
```


## cherri_train

### Tool Description
Train a Cherri model.

### Metadata
- **Docker Image**: quay.io/biocontainers/cherri:0.8--pyh7cba7a3_0
- **Homepage**: https://github.com/BackofenLab/Cherri
- **Package**: https://anaconda.org/channels/bioconda/packages/cherri/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cherri train [-h] -i1 RRI_PATH -o OUT_PATH -r LIST_OF_REPLICATES
                    [LIST_OF_REPLICATES ...] -l CHROM_LEN_FILE -g GENOME
                    [-c [CONTEXT]] [-n EXPERIMENT_NAME] [-p PARAM_FILE]
                    [-st USE_STRUCTURE] [-i2 RBP_PATH] [-t RUN_TIME]
                    [-me MEMORYPERTHREAD] [-j N_JOBS] [-mi MIXED]
                    [-fh FILTER_HYBRID] [-on OUT_NAME] [-tp TEMP_DIR]
                    [-so [NO_SUB_OPT]] [-es EXP_SCORE_TH]
                    [-ca CONTEXT_ADDITIONAL] [-cv DO_CV] [-fo FOLDS]
                    [-mt METHODS]

optional arguments:
  -h, --help            show this help message and exit
  -c [CONTEXT], --context [CONTEXT]
                        How much context should be added at up- and downstream
                        of the sequence. Default: 150
  -n EXPERIMENT_NAME, --experiment_name EXPERIMENT_NAME
                        Name of the data source of RRIs. Will be used for the
                        file names. Default: 'model_rri'
  -p PARAM_FILE, --param_file PARAM_FILE
                        IntaRNA parameter file. Default: file in
                        path_to_cherri_folder/Cherri/rrieval/IntaRNA_param
  -st USE_STRUCTURE, --use_structure USE_STRUCTURE
                        Set 'off' if you want to disable graph-kernel
                        features. Default: 'on' (when set to 'on' the feature
                        optimization will be performed directly and the data
                        will be stored in feature_files and no model/feature
                        folder will be created)
  -i2 RBP_PATH, --RBP_path RBP_PATH
                        Path to the genomic RBP crosslink or binding site
                        locations (in BED format)
  -t RUN_TIME, --run_time RUN_TIME
                        Time used for the optimization in seconds. Default:
                        43200 (12h)
  -me MEMORYPERTHREAD, --memoryPerThread MEMORYPERTHREAD
                        Memory in MB each thread can use (total ram/threads).
                        Default: 4300
  -j N_JOBS, --n_jobs N_JOBS
                        Number of jobs used for graph feature computation and
                        model selection. Default: 1
  -mi MIXED, --mixed MIXED
                        Use mixed model to combine different datasets into a
                        combined model. Default: 'off'
  -fh FILTER_HYBRID, --filter_hybrid FILTER_HYBRID
                        Filter the data for hybrids already detected by ChiRA
                        (set 'on' to filter). Default:'off'
  -on OUT_NAME, --out_name OUT_NAME
                        Name for the output directory, default
                        'date_Cherri_evaluating_RRIs'. Default:
                        'date_cherri_train'
  -tp TEMP_DIR, --temp_dir TEMP_DIR
                        Set a temporary directory for autosklearn. Either
                        proved a path or 'out' to set it to the output
                        directory. Default: 'off'
  -so [NO_SUB_OPT], --no_sub_opt [NO_SUB_OPT]
                        # of interactions IntraRNA will give is possible.
                        Default: 5
  -es EXP_SCORE_TH, --exp_score_th EXP_SCORE_TH
                        score threshold for the additional occupied regions
                        [BED]. Default: 10
  -ca CONTEXT_ADDITIONAL, --context_additional CONTEXT_ADDITIONAL
                        context to extend left and right for the BED file
                        instances. Default: 5
  -cv DO_CV, --do_cv DO_CV
                        5-fold cross validated of the pipeline will be
                        performed using the training data. Set 'off' to skip.
                        Default: 'on'
  -fo FOLDS, --folds FOLDS
                        number of folds for the cross validation. Default: 5
  -mt METHODS, --methods METHODS
                        Methods used for model selection. Default: any

required arguments:
  -i1 RRI_PATH, --RRI_path RRI_PATH
                        Path to folder storing the ChiRA interaction summary
                        files
  -o OUT_PATH, --out_path OUT_PATH
                        Path to output directory where the output folder will
                        be stored. It will contain separate output folders for
                        each step of the data, feature and model preparation
  -r LIST_OF_REPLICATES [LIST_OF_REPLICATES ...], --list_of_replicates LIST_OF_REPLICATES [LIST_OF_REPLICATES ...]
                        List the ChiRA interaction summary file for each
                        replicate
  -l CHROM_LEN_FILE, --chrom_len_file CHROM_LEN_FILE
                        Tabular file containing data in two-column format for
                        each chromosome: 'chrom name' 'chrom length'. You can
                        directly specify 'human' or 'mouse'
  -g GENOME, --genome GENOME
                        Path to genome FASTA file, or use the built-in
                        download function if you want the human or mouse
                        genome
```

