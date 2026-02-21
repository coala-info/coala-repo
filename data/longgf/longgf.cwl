cwlVersion: v1.2
class: CommandLineTool
baseCommand: longgf
label: longgf
doc: "A tool for detecting genomic fusions from long-read sequencing data (Note: The
  provided help text contains only container execution errors and no usage information).\n
  \nTool homepage: https://github.com/WGLab/LongGF"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longgf:0.1.2--h9948957_9
stdout: longgf.out
