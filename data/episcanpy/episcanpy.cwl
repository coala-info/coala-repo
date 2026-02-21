cwlVersion: v1.2
class: CommandLineTool
baseCommand: episcanpy
label: episcanpy
doc: "Episcanpy is a python library to analyze single-cell epigenomics data (ATAC-seq,
  DNA methylation, etc.). Note: The provided input text contains container runtime
  errors and does not include the actual help documentation for the tool.\n\nTool
  homepage: http://github.com/colomemaria/epiScanpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/episcanpy:0.4.0--pyhdfd78af_0
stdout: episcanpy.out
