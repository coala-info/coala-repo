cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - AMPd-Up.py
label: ampd-up_AMPd-Up
doc: "Generate antimicrobial peptide sequences with recurrent neural network. Users
  can either generate sequences by training new models or from the existing models.\n\
  \nTool homepage: https://github.com/bcgsc/AMPd-Up"
inputs:
  - id: amp_train
    type:
      - 'null'
      - Directory
    doc: Directory of training data (fasta format); only specify this argument 
      if you want to train AMPd-Up with your own data (optional)
    inputBinding:
      position: 101
      prefix: --amp_train
  - id: from_model
    type:
      - 'null'
      - Directory
    doc: Directory of the existing models; only specify this argument if you 
      want to sample from existing models (optional)
    inputBinding:
      position: 101
      prefix: --from_model
  - id: num_seq
    type: int
    doc: Number of sequences to sample
    inputBinding:
      position: 101
      prefix: --num_seq
  - id: out_format
    type:
      - 'null'
      - string
    doc: Output format, fasta or tsv (tsv by default, optional)
    inputBinding:
      position: 101
      prefix: --out_format
  - id: save_model
    type:
      - 'null'
      - string
    doc: Prefix of the models if you want to save them; only specify this 
      argument if you want to sample by training new models (optional)
    inputBinding:
      position: 101
      prefix: --save_model
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory (optional)
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ampd-up:1.0.1--pyhdfd78af_0
