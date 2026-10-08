cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - flexi_formatter
  - main
label: flexi-formatter_main
doc: "Move the flexiplex barcode and UMI from the read name of a SAM file to the CB
  and UR tags. The reformatted SAM is written to standard output.\n\nTool homepage:
  https://github.com/VIB-CCB-BioIT/flexiplex_tag_formatter"
inputs:
  - id: infile
    type: File
    doc: Input SAM file with flexiplex read names
    inputBinding:
      position: 1
outputs:
  - id: formatted_sam
    type: stdout
    doc: SAM file with CB and UR tags added
stdout: flexi-formatter_main.sam
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexi-formatter:1.0.1--pyhdfd78af_0
