cwlVersion: v1.2
class: CommandLineTool
baseCommand: groot get
label: groot_get
doc: "Download a pre-clustered ARG database\n\nTool homepage: https://github.com/will-rowe/groot"
inputs:
  - id: database
    type:
      - 'null'
      - string
    doc: 'database to download (please choose: arg-annot/resfinder/card/groot-db/groot-core-db)'
    default: arg-annot
    inputBinding:
      position: 101
      prefix: --database
  - id: identity
    type:
      - 'null'
      - string
    doc: the sequence identity used to cluster the database (only 90 available 
      atm)
    default: '90'
    inputBinding:
      position: 101
      prefix: --identity
  - id: index_dir
    type:
      - 'null'
      - Directory
    doc: directory for to write/read the GROOT index files
    inputBinding:
      position: 101
      prefix: --indexDir
  - id: log
    type:
      - 'null'
      - string
    doc: filename for log file
    default: groot.log
    inputBinding:
      position: 101
      prefix: --log
  - id: out
    type:
      - 'null'
      - Directory
    doc: directory to save the database to
    default: .
    inputBinding:
      position: 101
      prefix: --out
  - id: processors
    type:
      - 'null'
      - int
    doc: number of processors to use
    default: 1
    inputBinding:
      position: 101
      prefix: --processors
  - id: profiling
    type:
      - 'null'
      - boolean
    doc: create the files needed to profile GROOT using the go tool pprof
    inputBinding:
      position: 101
      prefix: --profiling
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/groot:1.1.2--h047eeb3_7
stdout: groot_get.out
