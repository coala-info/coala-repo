cwlVersion: v1.2
class: CommandLineTool
baseCommand: scanpy
label: scanpy
doc: "Scanpy is a scalable toolkit for analyzing single-cell gene expression data.
  (Note: The provided text appears to be a container build log rather than help text;
  no arguments could be extracted.)\n\nTool homepage: https://scanpy.readthedocs.io/en/latest/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanpy:1.7.2--pyhdfd78af_0
stdout: scanpy.out
