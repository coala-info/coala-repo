cwlVersion: v1.2
class: CommandLineTool
baseCommand: clame
label: clame
doc: "The provided text does not contain help information or usage instructions for
  the tool 'clame'. It appears to be a log of a failed container build or execution
  due to insufficient disk space.\n\nTool homepage: https://github.com/andvides/CLAME"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clame:1.0--h503566f_3
stdout: clame.out
