cwlVersion: v1.2
class: CommandLineTool
baseCommand: GDmicro.py
label: gdmicro
doc: "Use GCN and domain adaptation to predict disease based on microbiome data.\n\
  \nTool homepage: https://github.com/liaoherui/GDmicro"
inputs:
  - id: apply_node
    type:
      - 'null'
      - string
    doc: If set to 1, then will apply node importance calculation, which may 
      take a long time.
    default: not use
    inputBinding:
      position: 101
      prefix: --apply_node
  - id: batchsize
    type:
      - 'null'
      - int
    doc: The batch size during the training process.
    default: 64
    inputBinding:
      position: 101
      prefix: --batchsize
  - id: cvfold
    type:
      - 'null'
      - int
    doc: The value of k in k-fold cross validation.
    default: 10
    inputBinding:
      position: 101
      prefix: --cvfold
  - id: disease
    type:
      - 'null'
      - string
    doc: The name of the disease.
    inputBinding:
      position: 101
      prefix: --disease
  - id: domain_adapt
    type:
      - 'null'
      - string
    doc: Whether apply domain adaptation to the test dataset. If set to 0, then 
      will use MLP rather than domain adaptation.
    default: use
    inputBinding:
      position: 101
      prefix: --domain_adapt
  - id: feature_num
    type:
      - 'null'
      - string
    doc: How many features (top x features) will be analyzed during the feature 
      influence score calculation process.
    default: x=10
    inputBinding:
      position: 101
      prefix: --feature_num
  - id: input_file
    type:
      - 'null'
      - Directory
    doc: The directory of the input csv file.
    inputBinding:
      position: 101
      prefix: --input_file
  - id: kneighbor
    type:
      - 'null'
      - int
    doc: The number of neighborhoods in the knn graph.
    default: 5
    inputBinding:
      position: 101
      prefix: --kneighbor
  - id: node_num
    type:
      - 'null'
      - int
    doc: How many nodes will be output during the node importance calculation 
      process.
    default: 20
    inputBinding:
      position: 101
      prefix: --node_num
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory of test results.
    default: GDmicro_res
    inputBinding:
      position: 101
      prefix: --outdir
  - id: randomseed
    type:
      - 'null'
      - string
    doc: The random seed used to reproduce the result.
    default: not use
    inputBinding:
      position: 101
      prefix: --randomseed
  - id: run_fi
    type:
      - 'null'
      - int
    doc: Whether run feature importance calculation process. If set to 0, then 
      will not calculate the feature importance and contribution score.
    default: 1
    inputBinding:
      position: 101
      prefix: --run_fi
  - id: train_mode
    type:
      - 'null'
      - string
    doc: If set to 1, then will apply k-fold cross validation to all input 
      datasets. This mode can only be used when input datasets all have labels 
      and set as "train" in input file.
    inputBinding:
      position: 101
      prefix: --train_mode
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdmicro:1.0.10--pyhdfd78af_0
stdout: gdmicro.out
