cwlVersion: v1.2
class: CommandLineTool
baseCommand: fiona
label: fiona
doc: "Fiona is a CLI tool for reading and writing geospatial data files. (Note: The
  provided text contains container runtime error logs rather than the tool's help
  documentation, so specific arguments could not be extracted.)\n\nTool homepage:
  https://github.com/Toblerity/Fiona"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiona:1.8.6
stdout: fiona.out
