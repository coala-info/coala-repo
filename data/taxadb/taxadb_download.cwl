cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxadb_download
label: taxadb_download
doc: "download the files required to create the database\n\nTool homepage: https://github.com/HadrienG/taxadb"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force download if the output directory exists
    inputBinding:
      position: 101
      prefix: --force
  - id: outdir
    type: Directory
    doc: Output Directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Disable info logging.
    default: false
    inputBinding:
      position: 101
      prefix: --quiet
  - id: type
    type:
      type: array
      items: string
    doc: divisions to download. Can be one or more of "taxa", "full", "nucl", 
      "prot", "gb", or "wgs". Space- separated.
    inputBinding:
      position: 101
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable debug logging.
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxadb:0.12.1--pyh5e36f6f_0
stdout: taxadb_download.out
