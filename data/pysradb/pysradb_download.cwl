cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pysradb
  - download
label: pysradb_download
doc: "Download SRA data (runs of an SRA project, experiment or GEO series).\n\nTool
  homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: out_dir
    type:
      - 'null'
      - string
    doc: Output directory root
    inputBinding:
      position: 101
      prefix: --out-dir
  - id: srx
    type:
      - 'null'
      - type: array
        items: string
    doc: Download only these SRX(s)
    inputBinding:
      position: 101
      prefix: --srx
  - id: srp
    type:
      - 'null'
      - type: array
        items: string
    doc: SRP ID
    inputBinding:
      position: 101
      prefix: --srp
  - id: geo
    type:
      - 'null'
      - type: array
        items: string
    doc: GEO ID
    inputBinding:
      position: 101
      prefix: --geo
  - id: skip_confirmation
    type:
      - 'null'
      - boolean
    doc: Skip confirmation
    default: true
    inputBinding:
      position: 101
      prefix: --skip-confirmation
  - id: use_ascp
    type:
      - 'null'
      - boolean
    doc: Use aspera instead of wget
    inputBinding:
      position: 101
      prefix: --use_ascp
  - id: col
    type:
      - 'null'
      - string
    doc: Specify column to download
    inputBinding:
      position: 101
      prefix: --col
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: downloaded_dir
    type:
      - 'null'
      - Directory
    doc: Output directory with the downloaded data
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
stdout: pysradb_download.out
