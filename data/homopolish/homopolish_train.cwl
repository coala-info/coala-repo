cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - homopolish
  - train
label: homopolish_train
doc: "Train a model for homopolish using alignment dataframes.\n\nTool homepage: https://github.com/ythuang0522/homopolish"
inputs:
  - id: dataframe_dir
    type: Directory
    doc: Path to a directory for alignment dataframe.
    inputBinding:
      position: 101
      prefix: --dataframe_dir
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for the train model.
    default: train
    inputBinding:
      position: 101
      prefix: --output_prefix
  - id: pacbio
    type:
      - 'null'
      - boolean
    doc: Your train data is Pacbio.
    inputBinding:
      position: 101
      prefix: --pacbio
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to the output directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homopolish:0.4.2--pyhdfd78af_0
