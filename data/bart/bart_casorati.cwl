cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart_casorati
label: bart_casorati
doc: "Casorati matrix with kernel (kern1, ..., kernn) along dimensions (dim1, ...,
  dimn).\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: dimensions_and_kernels
    type:
      type: array
      items: string
    doc: Dimensions and kernels for the Casorati matrix
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
