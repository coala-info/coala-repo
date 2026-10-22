cwlVersion: v1.2
class: CommandLineTool
baseCommand: talon_summarize
label: talon_summarize
doc: "Generate a tab-delimited file of gene and transcript counts for each dataset in a TALON database (broken down by category).\n\nTool homepage: https://github.com/mortazavilab/TALON"
inputs:
  - id: database
    type: File
    doc: TALON database
    inputBinding:
      position: 101
      prefix: --db
  - id: groups
    type:
      - 'null'
      - File
    doc: "Optional: file of comma-delimited dataset groups to process together"
    inputBinding:
      position: 101
      prefix: --groups
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose mode: print out the counts in terminal"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: outprefix
    type: string
    doc: Prefix for output file
    inputBinding:
      position: 101
      prefix: --o
outputs:
  - id: summary
    type: File
    doc: Gene and transcript counts per dataset
    outputBinding:
      glob: $(inputs.outprefix)_talon_summary.tsv
  - id: stdout
    type: stdout
    doc: Standard output
stdout: talon_summarize.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
