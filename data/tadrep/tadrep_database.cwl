cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadrep
label: tadrep_database
doc: "Import external databases for TaDReP.\n\nTool homepage: https://github.com/oschwengers/tadrep"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose information
    inputBinding:
      position: 1
      prefix: --verbose
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default = number of available CPUs)
    inputBinding:
      position: 2
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Temporary directory to store blast hits
    inputBinding:
      position: 3
      prefix: --tmp-dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for all output files (default = None)
    inputBinding:
      position: 4
      prefix: --prefix
  - id: state_dir
    type:
      - 'null'
      - Directory
    doc: Output directory of a previous TaDReP step (database, extract, characterize, cluster, detect), which is staged writable and used as the working directory
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force download and new setup of database
    inputBinding:
      position: 101
      prefix: --force
  - id: type
    type:
      - 'null'
      - string
    doc: External DB to import (default = 'refseq')
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: tadrep_out
    type: Directory
    doc: TaDReP output directory (working directory for the next step)
    outputBinding:
      glob: tadrep_out
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 5
    prefix: --output
    valueFrom: tadrep_out
  - position: 10
    valueFrom: database
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.state_dir ? [{entry: inputs.state_dir, entryname: 'tadrep_out', writable: true}] : [])"
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
stdout: tadrep_database.out
