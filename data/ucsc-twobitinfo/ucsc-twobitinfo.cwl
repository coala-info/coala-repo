cwlVersion: v1.2
class: CommandLineTool
baseCommand: twoBitInfo
label: ucsc-twobitinfo
doc: "Get information about a .2bit file, including sequences and their sizes.\n\n\
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_2bit
    type: File
    doc: Input .2bit file
    inputBinding:
      position: 1
  - id: n_bed
    type:
      - 'null'
      - boolean
    doc: Create a BED file of N's (gaps) in the sequences
    inputBinding:
      position: 102
      prefix: -nBed
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not print the header line in the output
    inputBinding:
      position: 102
      prefix: -noHeader
outputs:
  - id: output_file
    type: File
    doc: Output tab-separated file containing sequence names and sizes
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-twobitinfo:482--hdc0a859_0
