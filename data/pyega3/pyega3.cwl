cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyega3
label: pyega3
doc: "The provided text does not contain a description of the tool as it is an error
  log from a container runtime failure.\n\nTool homepage: https://github.com/EGA-archive/ega-download-client"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyega3:5.2.0--pyhdfd78af_0
stdout: pyega3.out
