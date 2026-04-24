cwlVersion: v1.2
class: CommandLineTool
baseCommand: phamb_run_RF.py
label: phamb_run_RF.py
doc: "Run Random Forest model on features to predict viral or microbial origin of
  bins.\n\nTool homepage: https://github.com/RasmussenLab/phamb"
inputs:
  - id: input
    type: File
    doc: Path to the input features file (e.g., TSV or CSV)
    inputBinding:
      position: 101
      prefix: --input
  - id: model
    type: File
    doc: Path to the pre-trained Random Forest model file (.pkl)
    inputBinding:
      position: 101
      prefix: --model
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for processing
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: File
    doc: Path to the output file where predictions will be written
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phamb:1.0.1--pyhdfd78af_0
