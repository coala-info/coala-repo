cwlVersion: v1.2
class: CommandLineTool
baseCommand: blobtools
label: blobtools
doc: "A toolkit for the visualisation and diagnostic analysis of genome assemblies.\n\
  \nTool homepage: https://blobtools.readme.io/docs/what-is-blobtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtools:1.1.1--py_0
stdout: blobtools.out
