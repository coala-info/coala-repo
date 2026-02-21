cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlgenotype
label: mlgenotype
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage instructions for the mlgenotype tool.\n
  \nTool homepage: https://github.com/nhansen/mlgenotype"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlgenotype:0.1.12--pyhdfd78af_0
stdout: mlgenotype.out
