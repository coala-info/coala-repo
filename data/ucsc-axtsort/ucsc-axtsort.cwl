cwlVersion: v1.2
class: CommandLineTool
baseCommand: axtSort
label: ucsc-axtsort
doc: "Sort axt files. By default the input axt file is sorted by target sequence name\
  \ and target start position.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input
    type: File
    doc: Input axt file to be sorted
    inputBinding:
      position: 3
  - id: output_path
    type: string
    doc: Name of the sorted output axt file
    inputBinding:
      position: 4
  - id: query
    type:
      - 'null'
      - boolean
    doc: Sort by query position, not target
    inputBinding:
      position: 1
      prefix: -query
  - id: by_score
    type:
      - 'null'
      - boolean
    doc: Sort by score
    inputBinding:
      position: 2
      prefix: -byScore
outputs:
  - id: output
    type: File
    doc: Output sorted axt file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-axtsort:482--h0b57e2e_0
