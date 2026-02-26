cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlstdb update
label: mlstdb_update
doc: "Update MLST schemes and create BLAST database.\n\nDownloads MLST schemes from
  the specified input file and creates a BLAST\ndatabase from the downloaded sequences.
  Authentication tokens should be set\nup using fetch.py.\n\nTool homepage: https://github.com/himal2007/mlstdb"
inputs:
  - id: blast_directory
    type:
      - 'null'
      - string
    doc: Directory for BLAST database
    default: blast
    inputBinding:
      position: 101
      prefix: --blast-directory
  - id: directory
    type:
      - 'null'
      - string
    doc: Directory to save the downloaded MLST schemes
    default: pubmlst
    inputBinding:
      position: 101
      prefix: --directory
  - id: input_file
    type: string
    doc: "Path to mlst_schemes_<db>.tab containing MLST\nscheme URLs"
    inputBinding:
      position: 101
      prefix: --input
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose logging for debugging
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlstdb:0.2.0--pyh7e72e81_0
stdout: mlstdb_update.out
