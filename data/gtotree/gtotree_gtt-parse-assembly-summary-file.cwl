cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtt-parse-assembly-summary-file
label: gtotree_gtt-parse-assembly-summary-file
doc: "Parses NCBI's assembly summary file down to the provided accessions.

Tool homepage: https://github.com/AstrobioMike/GToTree"
inputs:
  - id: assembly_summary
    type: File
    doc: "NCBI's assembly summary file"
    inputBinding:
      position: 1
      prefix: -a
  - id: wanted_accessions
    type: File
    doc: "Single-column file with wanted accessions"
    inputBinding:
      position: 2
      prefix: -w
  - id: output_file
    type:
      - 'null'
      - string
    doc: "Wanted summary info only"
    default: Wanted.tsv
    inputBinding:
      position: 3
      prefix: -o
outputs:
  - id: wanted_summary
    type: File
    doc: "Summary info of the wanted accessions"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
