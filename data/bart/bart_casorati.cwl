cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, casorati]
requirements:
  - class: InlineJavascriptRequirement
label: bart_casorati
doc: "Casorati matrix with kernel (kern1, ..., kernn) along dimensions (dim1, ...,
  dimn).\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: dimensions_and_kernels
    type:
      type: array
      items: string
    doc: Dimensions and kernels for the Casorati matrix
    inputBinding:
      position: 10
  - id: input
    type: File
    doc: Input file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 12
outputs:
  - id: output
    type: File
    doc: Output file
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
