cwlVersion: v1.2
class: CommandLineTool
baseCommand: tombo
label: tombo
doc: "The provided text does not contain help information for the tool 'tombo'. It
  appears to be a log from a container build failure.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tombo:1.0--py27_0
stdout: tombo.out
