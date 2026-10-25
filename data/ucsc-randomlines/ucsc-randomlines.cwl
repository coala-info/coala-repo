cwlVersion: v1.2
class: CommandLineTool
baseCommand: randomLines
label: ucsc-randomlines
doc: "Pick out random lines from file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: The input file to sample lines from
    inputBinding:
      position: 1
  - id: line_count
    type: int
    doc: The number of random lines to extract
    inputBinding:
      position: 2
  - id: output_name
    type: string
    doc: Name of the output file where the random lines are written
    inputBinding:
      position: 3
  - id: seed
    type:
      - 'null'
      - int
    doc: Set seed used for randomizing, useful for debugging.
    inputBinding:
      position: 0
      prefix: -seed=
      separate: false
  - id: decomment
    type:
      - 'null'
      - boolean
    doc: Remove blank lines and those starting with '#'
    inputBinding:
      position: 0
      prefix: -decomment
outputs:
  - id: output_file
    type: File
    doc: The output file where random lines are written
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-randomlines:482--h0b57e2e_0
