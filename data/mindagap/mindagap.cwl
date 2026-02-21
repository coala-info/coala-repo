cwlVersion: v1.2
class: CommandLineTool
baseCommand: mindagap
label: mindagap
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding disk space during
  a container build.\n\nTool homepage: https://github.com/ViriatoII/MindaGap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mindagap:0.0.2--pyhdfd78af_1
stdout: mindagap.out
