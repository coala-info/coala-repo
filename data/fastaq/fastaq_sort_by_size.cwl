cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq sort_by_size
label: fastaq_sort_by_size
doc: "Sorts sequences in length order\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file
    inputBinding:
      position: 1
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Sort by shortest first instead of the default of longest first
    inputBinding:
      position: 102
      prefix: --reverse
outputs:
  - id: outfile
    type: File
    doc: Name of output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
