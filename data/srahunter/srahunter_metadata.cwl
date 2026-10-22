cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - srahunter
  - metadata
label: srahunter_metadata
doc: "Accession list from SRA (file path)\n\nTool homepage: https://github.com/GitEnricoNeko/srahunter"
inputs:
  - id: list
    type: File
    doc: Accession list from SRA (file path)
    inputBinding:
      position: 101
      prefix: --list
  - id: no_html
    type:
      - 'null'
      - boolean
    doc: Disable HTML table generation
    inputBinding:
      position: 101
      prefix: --no-html
outputs:
  - id: output_srahunter
    type:
      - 'null'
      - Directory
    doc: Output folder with SRA_info.csv and failed_metadata.csv
    outputBinding:
      glob: output_srahunter
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srahunter:0.0.9--pyhdfd78af_0
stdout: srahunter_metadata.out
