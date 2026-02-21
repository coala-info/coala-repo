cwlVersion: v1.2
class: CommandLineTool
baseCommand: marvd2
label: marvd2
doc: "Metagenomic Analysis and Retrieval of Viral Data (marvd2)\n\nTool homepage:
  https://bitbucket.org/MAVERICLab/marvd2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/marvd2:0.11.9--pyhdfd78af_0
stdout: marvd2.out
