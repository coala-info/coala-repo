cwlVersion: v1.2
class: CommandLineTool
baseCommand: minced
label: minced
doc: "MinCED is a program to find Clustered Regularly Interspaced Short Palindromic
  Repeats (CRISPRs) in full genomes or environmental datasets.\n\nTool homepage: https://github.com/ctSkennerton/minced"
inputs:
  - id: input_file
    type: File
    doc: Input genome file (FASTA format)
    inputBinding:
      position: 1
  - id: gff
    type:
      - 'null'
      - boolean
    doc: output in GFF format
    inputBinding:
      position: 102
      prefix: -gff
  - id: max_rl
    type:
      - 'null'
      - int
    doc: maximum repeat length
    inputBinding:
      position: 102
      prefix: -maxRL
  - id: max_sl
    type:
      - 'null'
      - int
    doc: maximum spacer length
    inputBinding:
      position: 102
      prefix: -maxSL
  - id: min_nr
    type:
      - 'null'
      - int
    doc: minimum number of repeats
    inputBinding:
      position: 102
      prefix: -minNR
  - id: min_rl
    type:
      - 'null'
      - int
    doc: minimum repeat length
    inputBinding:
      position: 102
      prefix: -minRL
  - id: min_sl
    type:
      - 'null'
      - int
    doc: minimum spacer length
    inputBinding:
      position: 102
      prefix: -minSL
  - id: search_wl
    type:
      - 'null'
      - int
    doc: search window length
    inputBinding:
      position: 102
      prefix: -searchWL
  - id: spacers
    type:
      - 'null'
      - boolean
    doc: output spacers in Fasta format
    inputBinding:
      position: 102
      prefix: -spacers
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for CRISPR identification results
    outputBinding:
      glob: '*.out'
  - id: gff_file
    type:
      - 'null'
      - File
    doc: Optional GFF output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minced:0.4.2--0
