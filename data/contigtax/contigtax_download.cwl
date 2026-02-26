cwlVersion: v1.2
class: CommandLineTool
baseCommand: contigtax_download
label: contigtax_download
doc: "Download contigtax databases\n\nTool homepage: https://github.com/NBISweden/contigtax"
inputs:
  - id: database
    type:
      - 'null'
      - string
    doc: Database to download. Defaults to 'uniref100'
    default: uniref100
    inputBinding:
      position: 1
  - id: download_directory
    type:
      - 'null'
      - Directory
    doc: Write files to this directory. Defaults to db name in current 
      directory. Will be created if missing.
    inputBinding:
      position: 102
      prefix: --dldir
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite downloaded files
    inputBinding:
      position: 102
      prefix: --force
  - id: skip_check
    type:
      - 'null'
      - boolean
    doc: 'Skip check of downloaded fasta file. Default: False'
    default: false
    inputBinding:
      position: 102
      prefix: --skip_check
  - id: skip_idmap
    type:
      - 'null'
      - boolean
    doc: Skip download of seqid->taxid mapfile (only applies to 'nr' database).
    inputBinding:
      position: 102
      prefix: --skip_idmap
  - id: sqlitedb
    type:
      - 'null'
      - string
    doc: Name of ete3 sqlite file to be created within --taxdir. Defaults to 
      'taxonomy.sqlite'
    default: taxonomy.sqlite
    inputBinding:
      position: 102
      prefix: --sqlitedb
  - id: taxdir
    type:
      - 'null'
      - Directory
    doc: Directory to store NCBI taxdump files. Defaults to 'taxonomy/' in 
      current directory
    default: taxonomy/
    inputBinding:
      position: 102
      prefix: --taxdir
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Temporary directory for downloading files
    inputBinding:
      position: 102
      prefix: --tmpdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
stdout: contigtax_download.out
