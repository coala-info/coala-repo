# flexynesis CWL Generation Report

## flexynesis

### Tool Description
Flexynesis model training interface

### Metadata
- **Docker Image**: quay.io/biocontainers/flexynesis:1.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/BIMSBbioinfo/flexynesis
- **Package**: https://anaconda.org/channels/bioconda/packages/flexynesis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/flexynesis/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/BIMSBbioinfo/flexynesis
- **Stars**: N/A
### Original Help Text
```text
usage: flexynesis [-h] [-v] [--data_path DATA_PATH]
                  [--model_class {DirectPred,supervised_vae,MultiTripletNetwork,CrossModalPred,GNN,RandomForest,SVM,XGBoost,RandomSurvivalForest}]
                  [--gnn_conv_type {GC,GCN,SAGE}]
                  [--target_variables TARGET_VARIABLES]
                  [--covariates COVARIATES] [--surv_event_var SURV_EVENT_VAR]
                  [--surv_time_var SURV_TIME_VAR] [--config_path CONFIG_PATH]
                  [--fusion_type {early,intermediate}] [--hpo_iter HPO_ITER]
                  [--finetuning_samples FINETUNING_SAMPLES]
                  [--variance_threshold VARIANCE_THRESHOLD]
                  [--correlation_threshold CORRELATION_THRESHOLD]
                  [--restrict_to_features RESTRICT_TO_FEATURES]
                  [--subsample SUBSAMPLE] [--features_min FEATURES_MIN]
                  [--features_top_percentile FEATURES_TOP_PERCENTILE]
                  [--data_types DATA_TYPES] [--input_layers INPUT_LAYERS]
                  [--output_layers OUTPUT_LAYERS] [--outdir OUTDIR]
                  [--prefix PREFIX] [--log_transform {True,False}]
                  [--early_stop_patience EARLY_STOP_PATIENCE]
                  [--hpo_patience HPO_PATIENCE] [--val_size VAL_SIZE]
                  [--use_cv] [--use_loss_weighting {True,False}]
                  [--evaluate_baseline_performance] [--threads THREADS]
                  [--num_workers NUM_WORKERS] [--use_gpu]
                  [--device {auto,cuda,mps,cpu}]
                  [--feature_importance_method {IntegratedGradients,GradientShap,Both}]
                  [--disable_marker_finding]
                  [--string_organism STRING_ORGANISM]
                  [--string_node_name {gene_name,gene_id}]
                  [--user_graph USER_GRAPH] [--safetensors]
                  [--pretrained_model PRETRAINED_MODEL]
                  [--artifacts ARTIFACTS] [--data_path_test DATA_PATH_TEST]
                  [--join_key JOIN_KEY]

Flexynesis model training interface

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  --data_path DATA_PATH
                        Path to the folder with train/test data files
                        (default: None)
  --model_class {DirectPred,supervised_vae,MultiTripletNetwork,CrossModalPred,GNN,RandomForest,SVM,XGBoost,RandomSurvivalForest}
                        The kind of model class to instantiate (default: None)
  --gnn_conv_type {GC,GCN,SAGE}
                        If model_class is set to GNN, choose which graph
                        convolution type to use (default: None)
  --target_variables TARGET_VARIABLES
                        (Optional if survival variables are not set to None).
                        Which variables in 'clin.csv' to use for predictions,
                        comma-separated if multiple (default: None)
  --covariates COVARIATES
                        Which variables in 'clin.csv' to be used as feature
                        covariates, comma-separated if multiple (default:
                        None)
  --surv_event_var SURV_EVENT_VAR
                        Which column in 'clin.csv' to use as event/status
                        indicator for survival modeling (default: None)
  --surv_time_var SURV_TIME_VAR
                        Which column in 'clin.csv' to use as time/duration
                        indicator for survival modeling (default: None)
  --config_path CONFIG_PATH
                        Optional path to an external hyperparameter
                        configuration file in YAML format. (default: None)
  --fusion_type {early,intermediate}
                        How to fuse the omics layers (default: intermediate)
  --hpo_iter HPO_ITER   Number of iterations for hyperparameter optimisation
                        (default: 100)
  --finetuning_samples FINETUNING_SAMPLES
                        Number of samples from the test dataset to use for
                        fine-tuning the model. Set to 0 to disable fine-tuning
                        (default: 0)
  --variance_threshold VARIANCE_THRESHOLD
                        Variance threshold (as percentile) to drop low
                        variance features (default is 1; set to 0 for no
                        variance filtering) (default: 1)
  --correlation_threshold CORRELATION_THRESHOLD
                        Correlation threshold to drop highly redundant
                        features (default is 0.8; set to 1 for no redundancy
                        filtering) (default: 0.8)
  --restrict_to_features RESTRICT_TO_FEATURES
                        Restrict the analyis to the list of features provided
                        by the user (default is None) (default: None)
  --subsample SUBSAMPLE
                        Downsample training set to randomly drawn N samples
                        for training. Disabled when set to 0 (default: 0)
  --features_min FEATURES_MIN
                        Minimum number of features to retain after feature
                        selection (default: 500)
  --features_top_percentile FEATURES_TOP_PERCENTILE
                        Top percentile features (among the features remaining
                        after variance filtering and data cleanup) to retain
                        after feature selection (default: 20)
  --data_types DATA_TYPES
                        Which omic data matrices to work on, comma-separated:
                        e.g. 'gex,cnv' (default: None)
  --input_layers INPUT_LAYERS
                        If model_class is set to CrossModalPred, choose which
                        data types to use as input/encoded layers. Comma-
                        separated if multiple (default: None)
  --output_layers OUTPUT_LAYERS
                        If model_class is set to CrossModalPred, choose which
                        data types to use as output/decoded layers. Comma-
                        separated if multiple (default: None)
  --outdir OUTDIR       Path to the output folder to save the model outputs
                        (default: /)
  --prefix PREFIX       Job prefix to use for output files (default: job)
  --log_transform {True,False}
                        whether to apply log-transformation to input data
                        matrices (default: False)
  --early_stop_patience EARLY_STOP_PATIENCE
                        How many epochs to wait when no improvements in
                        validation loss is observed (default 10; set to -1 to
                        disable early stopping) (default: 10)
  --hpo_patience HPO_PATIENCE
                        How many hyperparamater optimisation iterations to
                        wait for when no improvements are observed (default is
                        10; set to 0 to disable early stopping) (default: 20)
  --val_size VAL_SIZE   Proportion of training data to be used as validation
                        split (default: 0.2) (default: 0.2)
  --use_cv              (Optional) If set, the a 5-fold cross-validation
                        training will be done. Otherwise, a single trainig on
                        80 percent of the dataset is done. (default: False)
  --use_loss_weighting {True,False}
                        whether to apply loss-balancing using uncertainty
                        weights method (default: True)
  --evaluate_baseline_performance
                        whether to run Random Forest + SVMs to see the
                        performance of off-the-shelf tools on the same dataset
                        (default: False)
  --threads THREADS     (Optional) How many threads to use when using CPU
                        (default is 4) (default: 4)
  --num_workers NUM_WORKERS
                        (Optional) How many workers to use for model training
                        (default is 0) (default: 0)
  --use_gpu             (Optional) DEPRECATED: Use --device instead. If set,
                        attempts to use CUDA/GPU if available. (default:
                        False)
  --device {auto,cuda,mps,cpu}
                        Device type: 'auto' (automatic detection), 'cuda'
                        (NVIDIA GPU), 'mps' (Apple Silicon), 'cpu' (default:
                        auto)
  --feature_importance_method {IntegratedGradients,GradientShap,Both}
                        Choose feature importance score method (default:
                        IntegratedGradients)
  --disable_marker_finding
                        (Optional) If set, marker discovery after model
                        training is disabled. (default: False)
  --string_organism STRING_ORGANISM
                        STRING DB organism id. (default: 9606)
  --string_node_name {gene_name,gene_id}
                        Type of node name. (default: gene_name)
  --user_graph USER_GRAPH
                        Path to user-provided gene-gene interaction network
                        file. Must have at least 3 columns: GeneA, GeneB,
                        Score. If provided, this will be used instead of
                        STRING DB. (default: None)
  --safetensors         If set, the model will be saved in the SafeTensors
                        format. Default is False. (default: False)
  --pretrained_model PRETRAINED_MODEL
                        Path to a saved model (.pth) to use for inference
                        (default: None)
  --artifacts ARTIFACTS
                        Path to artifacts .joblib saved during training
                        (default: None)
  --data_path_test DATA_PATH_TEST
                        Folder with test-only dataset for inference (default:
                        None)
  --join_key JOIN_KEY   Column name in 'clin.csv' (test metadata) used to join
                        sample IDs (default: JoinKey)
```

