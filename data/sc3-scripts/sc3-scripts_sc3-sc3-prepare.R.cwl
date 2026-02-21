cwlVersion: v1.2
class: CommandLineTool
baseCommand: sc3-sc3-prepare.R
label: sc3-scripts_sc3-sc3-prepare.R
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container image retrieval (Apptainer/Singularity). No arguments could
  be extracted.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
stdout: sc3-scripts_sc3-sc3-prepare.R.out
