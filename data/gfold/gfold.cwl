cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfold
label: gfold
doc: "The provided text does not contain help information for the tool 'gfold'. It
  contains error logs related to a container runtime (Apptainer/Singularity) failing
  to pull a Docker image due to insufficient disk space.\n\nTool homepage: https://github.com/nickgerace/gfold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfold:1.1.4--gsl2.2_2
stdout: gfold.out
