cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rgi
  - auto_load
label: rgi_rgi_auto_load
doc: "Automatically loads the CARD database, annotations and k-mer database (downloads the current CARD release).\n\nTool homepage: https://card.mcmaster.ca"
inputs:
  - id: clean
    type:
      - 'null'
      - boolean
    doc: removes temporary files
    inputBinding:
      position: 101
      prefix: --clean
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: local
    type:
      - 'null'
      - boolean
    doc: 'use local database (default: uses database in executable directory)'
    inputBinding:
      position: 101
      prefix: --local
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: local_db
    type:
      - 'null'
      - Directory
    doc: Local database directory (localDB) written when --local is used
    outputBinding:
      glob: localDB
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
stdout: rgi_rgi_auto_load.out
