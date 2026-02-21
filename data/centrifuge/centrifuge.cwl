cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuge
label: centrifuge
doc: "The provided text does not contain help information or usage instructions for
  the tool 'centrifuge'. It is a log of a failed container build/extraction process
  due to insufficient disk space.\n\nTool homepage: https://github.com/DaehwanKimLab/centrifuge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuge:1.0.4.2--h077b44d_1
stdout: centrifuge.out
