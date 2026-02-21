cwlVersion: v1.2
class: CommandLineTool
baseCommand: homoeditdistance
label: homoeditdistance
doc: "A tool for calculating edit distance (Note: The provided help text contains
  only system error logs and no usage information).\n\nTool homepage: https://github.com/AlBi-HHU/homo-edit-distance"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homoeditdistance:0.0.1--py_0
stdout: homoeditdistance.out
