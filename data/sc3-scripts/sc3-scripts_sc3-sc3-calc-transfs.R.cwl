cwlVersion: v1.2
class: CommandLineTool
baseCommand: sc3-sc3-calc-transfs.R
label: sc3-scripts_sc3-sc3-calc-transfs.R
doc: "The provided text does not contain help information; it is an error log from
  a container runtime (Apptainer/Singularity) indicating a failure to fetch the OCI
  image.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
stdout: sc3-scripts_sc3-sc3-calc-transfs.R.out
