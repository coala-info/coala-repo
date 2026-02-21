cwlVersion: v1.2
class: CommandLineTool
baseCommand: isonform_isON_pipeline.sh
label: isonform_isON_pipeline.sh
doc: "A pipeline script for isONform, likely used for isoform reconstruction from
  long-read sequencing data. (Note: The provided help text contains only system error
  logs and does not list specific command-line arguments).\n\nTool homepage: https://github.com/aljpetri/isONform"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isonform:0.3.4--pyh7cba7a3_0
stdout: isonform_isON_pipeline.sh.out
