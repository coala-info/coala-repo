cwlVersion: v1.2
class: CommandLineTool
baseCommand: ensembl-utils
label: ensembl-utils
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the ensembl-utils image due to insufficient disk space.\n\nTool homepage:
  https://www.ensembl.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensembl-utils:0.8.0--pyhdfd78af_0
stdout: ensembl-utils.out
