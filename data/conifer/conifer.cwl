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
      - float
    doc: filter kraken file by confidence score (keep reads with score >= this
      threshold)
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
  - id: summary
    type:
      - 'null'
      - boolean
    doc: output summary statistics for each taxonomy
    inputBinding:
      position: 101
      prefix: --summary
  - id: output_name
    type:
      - 'null'
      - string
    doc: name of the file that receives the standard output
    default: conifer_output.tsv
outputs:
  - id: output
    type: File
    doc: per-read scores, or per-taxon summary statistics with --summary
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conifer:1.0.3--h577a1d6_0
