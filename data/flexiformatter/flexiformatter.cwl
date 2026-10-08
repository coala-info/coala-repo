cwlVersion: v1.2
class: CommandLineTool
baseCommand: flexiformatter
label: flexiformatter
doc: "Move the flexiplex barcode and UMI from the read name of a SAM file to the CB
  and UR tags. The reformatted SAM is written to standard output.\n\nTool homepage:
  https://github.com/ljwharbers/flexiformatter"
inputs:
  - id: infile
    type: File
    doc: Input BAM/SAM file (SAM text with flexiplex read names)
    inputBinding:
      position: 1
outputs:
  - id: formatted_sam
    type: stdout
    doc: SAM file with CB and UR tags added
stdout: flexiformatter.sam
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flexiformatter:1.0.6--pyhdfd78af_0
