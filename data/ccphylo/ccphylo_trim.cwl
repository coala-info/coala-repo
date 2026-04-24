cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccphylo_trim
label: ccphylo_trim
doc: "Trims multiple alignments from different files, and merge them into one\n\n\
  Tool homepage: https://bitbucket.org/genomicepidemiology/ccphylo"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file(s)
    inputBinding:
      position: 101
      prefix: --input
  - id: methylation_motifs_file
    type:
      - 'null'
      - File
    doc: Mask methylation motifs from <file>
    inputBinding:
      position: 101
      prefix: --methylation_motifs
  - id: min_cov
    type:
      - 'null'
      - float
    doc: Minimum coverage
    inputBinding:
      position: 101
      prefix: --min_cov
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum overlapping length
    inputBinding:
      position: 101
      prefix: --min_len
  - id: output_flags
    type:
      - 'null'
      - int
    doc: Output flags
    inputBinding:
      position: 101
      prefix: --flag
  - id: proximity
    type:
      - 'null'
      - int
    doc: Minimum proximity between SNPs
    inputBinding:
      position: 101
      prefix: --proximity
  - id: reference
    type:
      - 'null'
      - string
    doc: Target reference
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
