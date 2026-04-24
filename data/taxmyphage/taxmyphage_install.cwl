cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxmyphage install
label: taxmyphage_install
doc: "Install taxmyphage databases and dependencies.\n\nTool homepage: https://github.com/amillard/tax_myPHAGE"
inputs:
  - id: database_folder
    type:
      - 'null'
      - Directory
    doc: Path to the database directory where the databases are stored.
    inputBinding:
      position: 101
      prefix: --db_folder
  - id: makeblastdb_path
    type:
      - 'null'
      - File
    doc: Path to the blastn executable
    inputBinding:
      position: 101
      prefix: --makeblastdb
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show verbose output. (For debugging purposes)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxmyphage:0.3.6--pyhdfd78af_0
stdout: taxmyphage_install.out
