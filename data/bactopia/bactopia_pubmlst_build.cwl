cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bactopia-pubmlst-build
label: bactopia_pubmlst_build
doc: "Build PubMLST databases for use with the 'mlst' Bactopia Tool.\n\nTool homepage:\
  \ https://github.com/bactopia/bactopia"
inputs:
  - id: database
    type: string
    doc: A known organism database to download. (Use 'all' to download all databases.)
    inputBinding:
      position: 1
      prefix: --database
  - id: ignore
    type:
      - 'null'
      - string
    doc: A comma separated list of databases to ignore.
    inputBinding:
      position: 1
      prefix: --ignore
  - id: skip_download
    type:
      - 'null'
      - boolean
    doc: Skip downloading the database files.
    inputBinding:
      position: 1
      prefix: --skip-download
  - id: skip_blast
    type:
      - 'null'
      - boolean
    doc: Skip building the BLAST database.
    inputBinding:
      position: 1
      prefix: --skip-blast
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of existing files.
    inputBinding:
      position: 1
      prefix: --force
  - id: site
    type:
      - 'null'
      - string
    doc: 'The site to use, pubmlst or pasteur [default: pubmlst]'
    inputBinding:
      position: 1
      prefix: --site
  - id: token_dir
    type: Directory
    doc: The directory where the token file is saved (made by bactopia-pubmlst-setup).
    inputBinding:
      position: 1
      prefix: --token-dir
  - id: out_dir
    type: string
    doc: The directory where the database files will be saved.
    inputBinding:
      position: 1
      prefix: --out-dir
    default: bactopia-mlst
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print debug related text.
    inputBinding:
      position: 1
      prefix: --verbose
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Only critical errors will be printed.
    inputBinding:
      position: 1
      prefix: --silent
outputs:
  - id: mlst_db
    type: Directory
    doc: PubMLST database files (schemes and BLAST database)
    outputBinding:
      glob: $(inputs.out_dir)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia:3.2.0--hdfd78af_0
