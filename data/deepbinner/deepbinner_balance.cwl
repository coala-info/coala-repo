cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepbinner balance
label: deepbinner_balance
doc: "Select balanced training set\n\nTool homepage: https://github.com/rrwick/Deepbinner"
inputs:
  - id: training_data
    type:
      type: array
      items: File
    doc: Files of raw training data produced by the prep command
    inputBinding:
      position: 1
  - id: barcodes
    type:
      - 'null'
      - string
    doc: A comma-delimited list of which barcodes to include
    default: include all barcodes
    inputBinding:
      position: 102
      prefix: --barcodes
  - id: random_signal
    type:
      - 'null'
      - float
    doc: This many random signals will be added to the output as no-barcode 
      training samples (expressed as a multiple of the balanced per-barcode 
      count
    default: 1.0
    inputBinding:
      position: 102
      prefix: --random_signal
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepbinner:0.2.0--py36hc873e9d_0
stdout: deepbinner_balance.out
