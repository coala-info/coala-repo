cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - consplice
  - ML
  - train
label: consplice_ML_train
doc: "Train a Random Forest model using ConSplice.\n\nTool homepage: https://github.com/mikecormier/ConSplice"
inputs:
  - id: patho_set
    type: File
    doc: 'The pathogenic variants for training (tab-delimited, with ConSplice, SpliceAI and SQUIRLS scores).'
    inputBinding:
      position: 1
      prefix: --patho-set
  - id: benign_set
    type: File
    doc: 'The benign variants for training (tab-delimited, with ConSplice, SpliceAI and SQUIRLS scores).'
    inputBinding:
      position: 1
      prefix: --benign-set
  - id: consplice_col
    type: string
    doc: 'The name of the ConSplice column in the pathogenic and benign training sets.'
    inputBinding:
      position: 1
      prefix: --consplice-col
  - id: spliceai_col
    type: string
    doc: 'The name of the SpliceAI column in the pathogenic and benign training sets.'
    inputBinding:
      position: 1
      prefix: --spliceai-col
  - id: squirls_col
    type: string
    doc: 'The name of the SQUIRLS column in the pathogenic and benign training sets.'
    inputBinding:
      position: 1
      prefix: --squirls-col
  - id: output_dir
    type:
      - 'null'
      - string
    doc: 'The name of the directory to create and store the trained model in. Default = ''ConSpliceML_Model''.'
    inputBinding:
      position: 1
      prefix: --output-dir
  - id: random_state
    type:
      - 'null'
      - int
    doc: 'The random state to use when training the model. Default = 156498.'
    inputBinding:
      position: 1
      prefix: --random-state
  - id: n_dt
    type:
      - 'null'
      - int
    doc: 'The number of decision trees in the random forest. Default = 1000.'
    inputBinding:
      position: 1
      prefix: --n-dt
outputs:
  - id: model_dir
    type: Directory
    doc: 'The directory with the trained ConSpliceML model.'
    outputBinding:
      glob: "$(inputs.output_dir ? inputs.output_dir : 'ConSpliceML_Model')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
