cwlVersion: v1.2
class: CommandLineTool
baseCommand: medaka
label: medaka
doc: "The provided text does not contain help information for the tool 'medaka'. It
  contains system log messages and a fatal error regarding container image conversion
  and disk space.\n\nTool homepage: https://github.com/nanoporetech/medaka"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/medaka:2.2.0--py311h1d3aea1_0
stdout: medaka.out
