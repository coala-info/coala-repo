cwlVersion: v1.2
class: CommandLineTool
baseCommand: homoeditdistance_hed
label: homoeditdistance_hed
doc: "A tool for calculating edit distance (Note: The provided text is an error log
  and does not contain usage instructions or argument definitions).\n\nTool homepage:
  https://github.com/AlBi-HHU/homo-edit-distance"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homoeditdistance:0.0.1--py_0
stdout: homoeditdistance_hed.out
