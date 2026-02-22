cwlVersion: v1.2
class: CommandLineTool
baseCommand: parse_mito_blast
label: parse_mito_blast
doc: "The provided text does not contain help documentation for the tool; it contains
  system error messages related to container execution and disk space limitations.\n\
  \nTool homepage: https://github.com/VGP/vgp-assembly/tree/master/pipeline/VGP_decontamination_pipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parse_mito_blast:1.0.2
stdout: parse_mito_blast.out
