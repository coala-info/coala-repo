cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdrpcatch databases
label: rdrpcatch_databases
doc: "Download & update RdRpCATCH databases. If databases are already installed in
  the specified directory, it will check for updates and download the latest version
  if available.\n\nTool homepage: https://github.com/dimitris-karapliafis/RdRpCATCH"
inputs:
  - id: add_custom_db
    type:
      - 'null'
      - File
    doc: Path to a custom, pressed pHMM database directory. This only works if 
      the supported databases have already been downloaded. Please point to the 
      directory the databases are stored ('rdrpcatch_dbs') using the 
      '--destination-dir' flag.
    inputBinding:
      position: 101
      prefix: --add-custom-db
  - id: concept_doi
    type:
      - 'null'
      - string
    doc: Zenodo Concept DOI for database repository
    inputBinding:
      position: 101
      prefix: --concept-doi
  - id: destination_dir
    type: Directory
    doc: Path to directory to download databases
    inputBinding:
      position: 101
      prefix: --destination-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdrpcatch:1.0.1.post1--pyhdfd78af_0
stdout: rdrpcatch_databases.out
