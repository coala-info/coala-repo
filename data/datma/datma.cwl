cwlVersion: v1.2
class: CommandLineTool
baseCommand: datma
label: datma
doc: "The provided text does not contain help information or usage instructions for
  the tool 'datma'. It appears to be a system error log indicating a failure to build
  or pull a container image due to insufficient disk space.\n\nTool homepage: https://github.com/andvides/DATMA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datma:2.0--hdfd78af_0
stdout: datma.out
