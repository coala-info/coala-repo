cwlVersion: v1.2
class: CommandLineTool
baseCommand: chopin2
label: chopin2
doc: "Supervised Classification with Hyperdimensional Computing.\n\nTool homepage:
  https://github.com/cumbof/chopin2"
inputs:
  - id: accuracy_threshold
    type:
      - 'null'
      - float
    doc: Stop the execution if the best accuracy achieved during the previous 
      group of runs is lower than this number
    inputBinding:
      position: 101
      prefix: --accuracy_threshold
  - id: accuracy_uncertainty_perc
    type:
      - 'null'
      - float
    doc: Take a run into account if its accuracy is lower than the best accuracy
      achieved in the same group, but greaterthan the best accuracy minus its 
      "accuracy_uncertainty_perc" percent
    inputBinding:
      position: 101
      prefix: --accuracy_uncertainty_perc
  - id: cite
    type:
      - 'null'
      - boolean
    doc: Print references and exit
    inputBinding:
      position: 101
      prefix: --cite
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Delete the classification model as soon as it produces the prediction 
      accuracy
    inputBinding:
      position: 101
      prefix: --cleanup
  - id: crossv_k
    type:
      - 'null'
      - int
    doc: Number of folds for cross validation. Cross validate HD models if 
      --crossv_k greater than 1
    inputBinding:
      position: 101
      prefix: --crossv_k
  - id: dataset
    type:
      - 'null'
      - File
    doc: Path to the dataset file
    inputBinding:
      position: 101
      prefix: --dataset
  - id: dimensionality
    type:
      - 'null'
      - int
    doc: Dimensionality of the HD model
    inputBinding:
      position: 101
      prefix: --dimensionality
  - id: dump
    type:
      - 'null'
      - boolean
    doc: Build a summary and log files
    inputBinding:
      position: 101
      prefix: --dump
  - id: features
    type:
      - 'null'
      - File
    doc: Path to a file with a single column containing the whole set or a 
      subset of feature
    inputBinding:
      position: 101
      prefix: --features
  - id: fieldsep
    type:
      - 'null'
      - string
    doc: Field separator
    inputBinding:
      position: 101
      prefix: --fieldsep
  - id: gpu
    type:
      - 'null'
      - boolean
    doc: Build the classification model on an NVidia powered GPU. This argument 
      is ignored if --spark is specified
    inputBinding:
      position: 101
      prefix: --gpu
  - id: group_min
    type:
      - 'null'
      - int
    doc: Minimum number of features among those specified with the --features 
      argument
    inputBinding:
      position: 101
      prefix: --group_min
  - id: keep_levels
    type:
      - 'null'
      - boolean
    doc: Do not delete the level hypervectors. It works in conjunction with 
      --cleanup only
    inputBinding:
      position: 101
      prefix: --keep_levels
  - id: levels
    type:
      - 'null'
      - int
    doc: Number of level hypervectors
    inputBinding:
      position: 101
      prefix: --levels
  - id: master
    type:
      - 'null'
      - string
    doc: Master node address
    inputBinding:
      position: 101
      prefix: --master
  - id: memory
    type:
      - 'null'
      - string
    doc: Executor memory
    inputBinding:
      position: 101
      prefix: --memory
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of parallel jobs for the creation of the HD model. This argument
      is ignored if --spark is enabled
    inputBinding:
      position: 101
      prefix: --nproc
  - id: pickle
    type:
      - 'null'
      - File
    doc: Path to the pickle file. If specified, "--dataset" and "--fieldsep" 
      parameters are not used
    inputBinding:
      position: 101
      prefix: --pickle
  - id: psplit_training
    type:
      - 'null'
      - float
    doc: Percentage of observations that will be used to train the model. The 
      remaining percentage will be used to test the classification model
    inputBinding:
      position: 101
      prefix: --psplit_training
  - id: retrain
    type:
      - 'null'
      - int
    doc: Number of retraining iterations
    inputBinding:
      position: 101
      prefix: --retrain
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed
    inputBinding:
      position: 101
      prefix: --seed
  - id: select_features
    type:
      - 'null'
      - boolean
    doc: 'This triggers the backward variable selection method for the identification
      of the most significant features. Warning: computationally intense!'
    inputBinding:
      position: 101
      prefix: --select_features
  - id: slices
    type:
      - 'null'
      - int
    doc: Number of slices in case --spark argument is enabled. This argument is 
      ignored if --gpu is enabled
    inputBinding:
      position: 101
      prefix: --slices
  - id: spark
    type:
      - 'null'
      - boolean
    doc: Build the classification model in a Apache Spark distributed 
      environment
    inputBinding:
      position: 101
      prefix: --spark
  - id: stop
    type:
      - 'null'
      - boolean
    doc: Stop retraining if the error rate does not change
    inputBinding:
      position: 101
      prefix: --stop
  - id: tblock
    type:
      - 'null'
      - int
    doc: Number of threads per block in case --gpu argument is enabled. This 
      argument is ignored if --spark is enabled
    inputBinding:
      position: 101
      prefix: --tblock
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print results in real time
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chopin2:1.0.9.post1
stdout: chopin2.out
