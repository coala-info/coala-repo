cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyham
label: pyham
doc: "The provided text does not contain help information or usage instructions for
  pyham. It appears to be a log of a failed container build/fetch process (Apptainer/Singularity).\n
  \nTool homepage: https://github.com/DessimozLab/pyham"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyham:1.1.11--pyh7cba7a3_0
stdout: pyham.out
