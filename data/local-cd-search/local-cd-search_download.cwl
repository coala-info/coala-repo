cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - local-cd-search
  - download
label: local-cd-search_download
doc: "Download one or more PSSM databases and CDD metadata into DB_DIR.\n\nTool homepage:
  https://github.com/apcamargo/local-cd-search"
inputs:
  - id: db_dir
    type: Directory
    doc: Directory to store downloaded databases
    inputBinding:
      position: 1
  - id: databases
    type:
      type: array
      items: string
    doc: One or more PSSM databases to download (cdd, cdd_ncbi, cog, kog, pfam, 
      prk, smart, tigr)
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force re-download even if files are present.
    inputBinding:
      position: 103
      prefix: --force
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress non-error console output.
    inputBinding:
      position: 103
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/local-cd-search:0.3.1--pyhdfd78af_0
stdout: local-cd-search_download.out
