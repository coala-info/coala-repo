cwlVersion: v1.2
class: CommandLineTool
baseCommand: goetia
label: goetia
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or argument definitions for the tool 'goetia'.\n
  \nTool homepage: https://github.com/camillescott/goetia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goetia:0.14--py37h13b99d1_1
stdout: goetia.out
