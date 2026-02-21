cwlVersion: v1.2
class: CommandLineTool
baseCommand: flippyr
label: flippyr
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the tool 'flippyr'.\n
  \nTool homepage: https://github.com/BEFH/flippyr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flippyr:0.6.1--pyh7e72e81_0
stdout: flippyr.out
