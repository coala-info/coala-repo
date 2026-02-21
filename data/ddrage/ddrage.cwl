cwlVersion: v1.2
class: CommandLineTool
baseCommand: ddrage
label: ddrage
doc: "The provided text does not contain help information for the tool 'ddrage'. It
  contains error logs related to a container runtime (Apptainer/Singularity) failing
  to build an image due to insufficient disk space.\n\nTool homepage: https://bitbucket.org/genomeinformatics/rage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddrage:1.8.1--pyhdfd78af_0
stdout: ddrage.out
