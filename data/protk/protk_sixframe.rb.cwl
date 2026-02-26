cwlVersion: v1.2
class: CommandLineTool
baseCommand: protk_sixframe.rb
label: protk_sixframe.rb
doc: "Create a sixframe translation of a genome.\n\nTool homepage: https://github.com/iracooke/protk"
inputs:
  - id: genome_fasta
    type: File
    doc: Input genome fasta file
    inputBinding:
      position: 1
  - id: coords
    type:
      - 'null'
      - boolean
    doc: Write genomic coordinates in the fasta header
    default: false
    inputBinding:
      position: 102
      prefix: --coords
  - id: gff3
    type:
      - 'null'
      - boolean
    doc: Output gff3 instead of fasta
    default: false
    inputBinding:
      position: 102
      prefix: --gff3
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum ORF length to keep
    default: 20
    inputBinding:
      position: 102
      prefix: --min-len
  - id: peptideshaker
    type:
      - 'null'
      - boolean
    doc: Format fasta output for peptideshaker compatibility
    default: false
    inputBinding:
      position: 102
      prefix: --peptideshaker
  - id: strip_header
    type:
      - 'null'
      - boolean
    doc: Dont write sequence definition
    default: true
    inputBinding:
      position: 102
      prefix: --strip-header
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: An explicitly named output file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/protk:1.4.4a--hc9114bc_1
