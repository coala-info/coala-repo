cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuge-download
label: centrifuge_centrifuge-download
doc: "The provided text is an error log from a container build process and does not
  contain help information or argument definitions for the centrifuge-download tool.\n
  \nTool homepage: https://github.com/DaehwanKimLab/centrifuge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuge:1.0.4.2--h077b44d_1
stdout: centrifuge_centrifuge-download.out
