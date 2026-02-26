cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - get_seq_flanking_gaps
label: fastaq_get_seq_flanking_gaps
doc: "Gets the sequences flanking gaps\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file
    inputBinding:
      position: 1
  - id: left
    type:
      - 'null'
      - int
    doc: Number of bases to get to left of gap
    default: 25
    inputBinding:
      position: 102
      prefix: --left
  - id: right
    type:
      - 'null'
      - int
    doc: Number of bases to get to right of gap
    default: 25
    inputBinding:
      position: 102
      prefix: --right
outputs:
  - id: outfile
    type: File
    doc: Name of output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
