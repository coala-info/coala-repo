cwlVersion: v1.2
class: CommandLineTool
baseCommand: bbmapy-ensure-java
label: bbmapy_bbmapy-ensure-java
doc: "A utility tool to ensure Java is properly configured and available for the bbmapy
  environment.\n\nTool homepage: https://github.com/urineri/bbmapy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbmapy:0.0.51--pyhdfd78af_0
stdout: bbmapy_bbmapy-ensure-java.out
