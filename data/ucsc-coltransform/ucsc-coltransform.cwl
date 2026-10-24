cwlVersion: v1.2
class: CommandLineTool
baseCommand: colTransform
label: ucsc-coltransform
doc: "Add and/or multiply column by constant.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: column
    type: int
    doc: The column to transform, starting with 1.
    inputBinding:
      position: 1
  - id: in_tab
    type: File
    doc: Tab-delimited input file.
    inputBinding:
      position: 2
  - id: add_factor
    type: double
    doc: What to add. Use 0 to not change anything.
    inputBinding:
      position: 3
  - id: mul_factor
    type: double
    doc: What to multiply by. Use 1 to not change anything.
    inputBinding:
      position: 4
  - id: out_tab
    type: string
    doc: Tab-delimited output file name.
    inputBinding:
      position: 5
outputs:
  - id: output_tab
    type: File
    doc: Tab-delimited output file.
    outputBinding:
      glob: $(inputs.out_tab)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-coltransform:482--h0b57e2e_0
