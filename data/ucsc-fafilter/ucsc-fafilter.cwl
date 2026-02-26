cwlVersion: v1.2
class: CommandLineTool
baseCommand: faFilter
label: ucsc-fafilter
doc: "Filter a fasta file based on various criteria such as name, size, or N content.\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_fa
    type: File
    doc: Input fasta file
    inputBinding:
      position: 1
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: Invert match (same as -notName)
    inputBinding:
      position: 102
      prefix: -v
  - id: max_n
    type:
      - 'null'
      - int
    doc: Keep sequences with at most N N's
    inputBinding:
      position: 102
      prefix: -maxN
  - id: max_size
    type:
      - 'null'
      - int
    doc: Keep sequences at most N bases long
    inputBinding:
      position: 102
      prefix: -maxSize
  - id: min_size
    type:
      - 'null'
      - int
    doc: Keep sequences at least N bases long
    inputBinding:
      position: 102
      prefix: -minSize
  - id: name
    type:
      - 'null'
      - string
    doc: Keep sequences matching wildCard
    inputBinding:
      position: 102
      prefix: -name
  - id: not_name
    type:
      - 'null'
      - string
    doc: Keep sequences not matching wildCard
    inputBinding:
      position: 102
      prefix: -notName
  - id: uniq
    type:
      - 'null'
      - boolean
    doc: Keep only first sequence with a given name
    inputBinding:
      position: 102
      prefix: -uniq
outputs:
  - id: output_fa
    type: File
    doc: Output filtered fasta file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fafilter:482--h0b57e2e_0
