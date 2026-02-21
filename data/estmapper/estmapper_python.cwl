cwlVersion: v1.2
class: CommandLineTool
baseCommand: estmapper
label: estmapper_python
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log indicating a failure to pull the estmapper image
  due to lack of disk space.\n\nTool homepage: https://github.com/estmapper/1234"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/estmapper:2008--py311pl5321hd8d945a_7
stdout: estmapper_python.out
