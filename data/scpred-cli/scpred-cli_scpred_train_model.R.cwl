cwlVersion: v1.2
class: CommandLineTool
baseCommand: scpred_train_model.R
label: scpred-cli_scpred_train_model.R
doc: "Trains a cell type classifier using scPred.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scPred-cli"
inputs:
  - id: allow_parallel
    type:
      - 'null'
      - boolean
    doc: Should parallel processing be allowed?
    default: true
    inputBinding:
      position: 101
      prefix: --allow-parallel
  - id: get_scpred
    type:
      - 'null'
      - boolean
    doc: Should scpred object be extracted from Seurat object after model 
      training?
    default: false
    inputBinding:
      position: 101
      prefix: --get-scpred
  - id: input_object
    type: File
    doc: Path to the input object of Seurat class in .rds format
    inputBinding:
      position: 101
      prefix: --input-object
  - id: iter_num
    type:
      - 'null'
      - int
    doc: Number of resampling iterations.
    default: 5
    inputBinding:
      position: 101
      prefix: --iter-num
  - id: metric
    type:
      - 'null'
      - string
    doc: Performance metric to be used to select best model
    inputBinding:
      position: 101
      prefix: --metric
  - id: model
    type:
      - 'null'
      - string
    doc: Model type used for training. Must be one of the models supported by 
      Caret package.
    default: svmRadial
    inputBinding:
      position: 101
      prefix: --model
  - id: num_cores
    type:
      - 'null'
      - int
    doc: For parallel processing, how many cores should be used?
    inputBinding:
      position: 101
      prefix: --num-cores
  - id: preprocess
    type:
      - 'null'
      - string
    doc: A string vector that defines a pre-processing of the predictor data. 
      Enter values as comma-separated string. Current possibilities are 
      'BoxCox', 'YeoJohnson', 'expoTrans', 'center', 'scale', 'range', 
      'knnImpute', 'bagImpute', 'medianImpute' 'pca', 'ica' and 'spatialSign'. 
      The default is 'center' and 'scale'.
    inputBinding:
      position: 101
      prefix: --preprocess
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random seed
    inputBinding:
      position: 101
      prefix: --random-seed
  - id: reclassify
    type:
      - 'null'
      - type: array
        items: string
    doc: Cell types to reclassify using a different model
    inputBinding:
      position: 101
      prefix: --reclassify
  - id: resample_method
    type:
      - 'null'
      - string
    doc: Resampling method used for model fit evaluation
    inputBinding:
      position: 101
      prefix: --resample-method
  - id: return_data
    type:
      - 'null'
      - boolean
    doc: If TRUE, training data is returned within scPred object.
    default: false
    inputBinding:
      position: 101
      prefix: --return-data
  - id: save_predictions
    type:
      - 'null'
      - string
    doc: Specifies the set of hold-out predictions for each resample that should
      be returned. Values can be either 'all', 'final' or 'none'.
    inputBinding:
      position: 101
      prefix: --save-predictions
  - id: train_id
    type:
      - 'null'
      - string
    doc: ID of the training dataset (optional)
    inputBinding:
      position: 101
      prefix: --train-id
  - id: tune_length
    type:
      - 'null'
      - int
    doc: An integer denoting the amount of granularity in the tuning parameter 
      grid
    inputBinding:
      position: 101
      prefix: --tune-length
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: Path for the output scPred object in .rds format
    outputBinding:
      glob: $(inputs.output_path)
  - id: train_probs_plot
    type:
      - 'null'
      - File
    doc: Path for training probabilities plot in .png format
    outputBinding:
      glob: $(inputs.train_probs_plot)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scpred-cli:0.1.0--hdfd78af_2
