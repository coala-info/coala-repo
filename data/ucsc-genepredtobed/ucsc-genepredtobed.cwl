cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredToBed
label: ucsc-genepredtobed
doc: "Convert from genePred to bed format. Does not yet handle genePredExt.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input
    type: File
    doc: The input genePred file.
    inputBinding:
      position: 1
  - id: output_name
    type: string
    doc: Name of the output BED file
    inputBinding:
      position: 2
  - id: tab
    type:
      - 'null'
      - boolean
    doc: genePred fields are separated by tab instead of just white space
    inputBinding:
      position: 101
      prefix: -tab
  - id: fill_space
    type:
      - 'null'
      - boolean
    doc: When tab input, fill space chars in 'name' with underscore
    inputBinding:
      position: 101
      prefix: -fillSpace
  - id: score
    type:
      - 'null'
      - int
    doc: Set score to N in bed output (default 0)
    inputBinding:
      position: 101
      prefix: -score=
      separate: false
outputs:
  - id: output
    type: File
    doc: The output BED file.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtobed:482--h0b57e2e_0
