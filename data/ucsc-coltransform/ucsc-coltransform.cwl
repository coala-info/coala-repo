cwlVersion: v1.2
class: CommandLineTool
baseCommand: colTransform
label: ucsc-coltransform
doc: "Transform a column in a file using various mathematical operations.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_file
    type: File
    doc: The input file containing the data to be transformed.
    inputBinding:
      position: 1
  - id: column
    type: int
    doc: The 1-based column number to transform.
    inputBinding:
      position: 2
  - id: operation
    type: string
    doc: The transformation operation to apply (e.g., log, log10, log2, exp, 
      exp10, exp2, sqrt, abs, round, ceil, floor).
    inputBinding:
      position: 3
outputs:
  - id: out_file
    type: File
    doc: The output file where the transformed data will be written.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-coltransform:482--h0b57e2e_0
