cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - get_seq_flanking_gaps
label: pyfastaq_fastaq_get_seq_flanking_gaps
doc: "Gets the sequences flanking gaps\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: left
    type:
      - 'null'
      - int
    doc: "Number of bases to get to left of gap [25]"
    inputBinding:
      position: 1
      prefix: --left
  - id: right
    type:
      - 'null'
      - int
    doc: "Number of bases to get to right of gap [25]"
    inputBinding:
      position: 2
      prefix: --right
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
