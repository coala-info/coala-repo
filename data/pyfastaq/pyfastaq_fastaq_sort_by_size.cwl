cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - sort_by_size
label: pyfastaq_fastaq_sort_by_size
doc: "Sorts sequences in length order\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: "Sort by shortest first instead of the default of longest first"
    inputBinding:
      position: 1
      prefix: --reverse
  - id: infile
    type: File
    doc: "Name of input file"
    inputBinding:
      position: 20
  - id: outfile
    type: string
    doc: "Name of output file"
    inputBinding:
      position: 21
outputs:
  - id: output
    type: File
    doc: "Name of output file"
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
