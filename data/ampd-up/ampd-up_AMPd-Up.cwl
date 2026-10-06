cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - AMPd-Up
label: ampd-up_AMPd-Up
doc: "Generate antimicrobial peptide sequences with recurrent neural network. Users
  can either generate sequences by training new models or from the existing models.\n\
  \nTool homepage: https://github.com/bcgsc/AMPd-Up"
inputs:
  - id: amp_train
    type:
      - 'null'
      - File
    doc: Training data file (fasta format); only specify this argument 
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
  - id: out_dir_path
    type: string
    inputBinding:
      position: 102
      prefix: --out_dir
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory (optional)
    outputBinding:
      glob: $(inputs.out_dir_path)
  - id: save_model_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in save_model
    outputBinding:
      glob: "$(inputs.save_model ? inputs.out_dir_path + '/' + inputs.save_model + '_*.pt'
        : [])"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', basename: inputs.out_dir_path, listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ampd-up:1.0.1--pyhdfd78af_0
