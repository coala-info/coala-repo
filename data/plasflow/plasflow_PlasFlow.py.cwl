cwlVersion: v1.2
class: CommandLineTool
baseCommand: PlasFlow.py
label: plasflow_PlasFlow.py
doc: "predicting plasmid sequences in metagenomic data using genome signatures. PlasFlow
  is based on the TensorFlow artificial neural network classifier\n\nTool homepage:
  https://github.com/smaegol/PlasFlow"
inputs:
  - id: input_file
    type: File
    doc: Input fasta file with sequences to classify (required)
    inputBinding:
      position: 101
      prefix: --input
  - id: labels
    type:
      - 'null'
      - File
    doc: Custom labels file
    inputBinding:
      position: 101
      prefix: --labels
  - id: models
    type:
      - 'null'
      - Directory
    doc: Custom models localization
    inputBinding:
      position: 101
      prefix: --models
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold for probability filtering (default=0.7)
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: output_file
    type: File
    doc: Output file with classification results (required)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasflow:1.1.0--py35_0
