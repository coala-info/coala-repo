cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuge-kreport
label: centrifuge_centrifuge-kreport
doc: "The provided text does not contain help information as it is a system error
  log indicating a failure to build the container image (no space left on device).\n
  \nTool homepage: https://github.com/DaehwanKimLab/centrifuge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuge:1.0.4.2--h077b44d_1
stdout: centrifuge_centrifuge-kreport.out
