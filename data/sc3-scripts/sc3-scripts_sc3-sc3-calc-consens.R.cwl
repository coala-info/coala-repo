cwlVersion: v1.2
class: CommandLineTool
baseCommand: sc3-sc3-calc-consens.R
label: sc3-scripts_sc3-sc3-calc-consens.R
doc: "Calculate consensus clusters for SC3 (Note: The provided help text contains
  only container runtime error messages and does not list specific arguments).\n\n
  Tool homepage: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
stdout: sc3-scripts_sc3-sc3-calc-consens.R.out
