cwlVersion: v1.2
class: CommandLineTool
baseCommand: container-mtbls-dwnld
label: container-mtbls-dwnld
doc: "A tool for downloading MetaboLights (MTBLS) datasets.\n\nTool homepage: https://github.com/phnmnl/container-mtbls-dwnld"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/container-mtbls-dwnld:latest
stdout: container-mtbls-dwnld.out
