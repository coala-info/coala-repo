cwlVersion: v1.2
class: CommandLineTool
baseCommand: novor
label: novor
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or usage information for the 'novor' tool.\n
  \nTool homepage: https://github.com/novorozen/novorepository"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/novor:v1b_cv5
stdout: novor.out
