cwlVersion: v1.2
class: CommandLineTool
baseCommand: conifer
label: conifer
doc: "Conifer: A tool for processing Kraken2 files and taxonomy data\n\nTool homepage:
  https://github.com/Ivarz/Conifer/"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: output all reads (including unclassified)
    inputBinding:
      position: 101
      prefix: --all
  - id: both_scores
    type:
      - 'null'
      - boolean
    doc: report confidence and root-to-leaf score
    inputBinding:
      position: 101
      prefix: --both_scores
  - id: db
    type: File
    doc: kraken2 taxo.k2d file
    inputBinding:
      position: 101
      prefix: --db
  - id: filter
    type:
      - 'null'
      - boolean
    doc: filter kraken file by confidence score
    inputBinding:
      position: 101
      prefix: --filter
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 101
      prefix: --input
  - id: rtl
    type:
      - 'null'
      - boolean
    doc: report root-to-leaf score instead of confidence score
    inputBinding:
      position: 101
      prefix: --rtl
outputs:
  - id: summary
    type:
      - 'null'
      - File
    doc: output summary statistics for each taxonomy
    outputBinding:
      glob: $(inputs.summary)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conifer:1.0.3--h577a1d6_0
