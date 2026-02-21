cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanocount
label: nanocount
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding disk space
  during a container build process.\n\nTool homepage: https://github.com/a-slide/NanoCount/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanocount:1.0.0.post6--pyhdfd78af_0
stdout: nanocount.out
