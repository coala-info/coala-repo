cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - architeuthis
  - mapping
label: architeuthis_mapping
doc: "A tool for processing Kraken output, including filtering, k-mer summarization,
  and scoring.\n\nTool homepage: https://github.com/cdiener/architeuthis"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: 'The subcommand to execute: filter, kmers, score, or summary'
    inputBinding:
      position: 1
  - id: db
    type:
      - 'null'
      - Directory
    doc: path to the Kraken database
    inputBinding:
      position: 102
      prefix: --db
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
stdout: architeuthis_mapping.out
