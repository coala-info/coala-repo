cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - srahunter
  - fullmetadata
label: srahunter_fullmetadata
doc: "Accession list from SRA (file path)\n\nTool homepage: https://github.com/GitEnricoNeko/srahunter"
inputs:
  - id: list
    type: File
    doc: Accession list from SRA (file path)
    inputBinding:
      position: 101
      prefix: --list
outputs:
  - id: output_srahunter
    type:
      - 'null'
      - Directory
    doc: Output folder with Full_SRA_info.csv and failed_metadata.csv
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
stdout: srahunter_fullmetadata.out
