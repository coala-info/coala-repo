cwlVersion: v1.2
class: CommandLineTool
baseCommand: methyldackel
label: methyldackel
doc: "A tool for extracting DNA methylation metrics from alignments. Note: The provided
  text contains system error messages and does not list specific command-line arguments.\n
  \nTool homepage: https://github.com/dpryan79/MethylDackel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methyldackel:0.6.1--h577a1d6_9
stdout: methyldackel.out
