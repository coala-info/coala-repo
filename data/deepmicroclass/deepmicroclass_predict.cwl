cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - DeepMicroClass
  - predict
label: deepmicroclass_predict
doc: "Predict the class (eukaryote, eukaryotic virus, plasmid, prokaryote, 
  prokaryotic virus) of metagenomic sequences\n\nTool homepage: 
  https://github.com/chengsly/DeepMicroClass"
inputs:
  - id: input
    type: File
    doc: Path to the input fasta file
    inputBinding:
      position: 101
      prefix: --input
  - id: output_dir
    type: string
    doc: Path to the output directory
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: model
    type:
      - 'null'
      - File
    doc: Path to the trained model
    inputBinding:
      position: 101
      prefix: --model
  - id: encoding
    type:
      - 'null'
      - string
    doc: Encoding method (onehot, embedding)
    inputBinding:
      position: 101
      prefix: --encoding
  - id: mode
    type:
      - 'null'
      - string
    doc: Prediction mode (hybrid, single)
    inputBinding:
      position: 101
      prefix: --mode
  - id: single_len
    type:
      - 'null'
      - int
    doc: Length to use in the single mode
    inputBinding:
      position: 101
      prefix: --single-len
  - id: device
    type:
      - 'null'
      - string
    doc: Device to use (cpu, cuda)
    inputBinding:
      position: 101
      prefix: --device
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
  - id: predictions
    type: File
    doc: Table of prediction scores per sequence
    outputBinding:
      glob: $(inputs.output_dir)/*_pred_*.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmicroclass:1.0.3--pyhdfd78af_1
