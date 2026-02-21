cwlVersion: v1.2
class: CommandLineTool
baseCommand: is6110
label: is6110
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the is6110 tool.\n
  \nTool homepage: https://github.com/jodyphelan/is6110"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/is6110:0.5.0--pyh7e72e81_0
stdout: is6110.out
