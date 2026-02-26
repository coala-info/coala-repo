cwlVersion: v1.2
class: CommandLineTool
baseCommand: phast_hmm_train
label: phast_hmm_train
doc: "Trains a Hidden Markov Model (HMM) for use with PHAST.\n\nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input files for training the HMM. These can be alignment files (e.g., 
      MAF) or other data formats depending on the specific HMM training process.
    inputBinding:
      position: 1
  - id: config_file
    type:
      - 'null'
      - File
    doc: A configuration file that specifies parameters and settings for the HMM
      training process.
    inputBinding:
      position: 102
      prefix: --config-file
  - id: iterations
    type:
      - 'null'
      - int
    doc: The number of EM (Expectation-Maximization) iterations to perform 
      during training.
    default: 10
    inputBinding:
      position: 102
      prefix: --iterations
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress most output during training.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: states
    type:
      - 'null'
      - int
    doc: The number of states to include in the HMM.
    inputBinding:
      position: 102
      prefix: --states
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output during training.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_model
    type:
      - 'null'
      - File
    doc: Specifies the file path to save the trained HMM model.
    outputBinding:
      glob: $(inputs.output_model)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
