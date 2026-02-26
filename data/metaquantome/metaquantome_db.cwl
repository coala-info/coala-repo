cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaquantome db
label: metaquantome_db
doc: "metaQuantome uses freely available bioinformatic databases to expand your set
  of direct annotations. For most cases, all 3 databases can be downloaded (the default).\n\
  \nTool homepage: https://github.com/galaxyproteomics/metaquant"
inputs:
  - id: databases
    type:
      type: array
      items: string
    doc: database to download. note that COG mode does not require a download 
      due to its simplicity.
    inputBinding:
      position: 1
  - id: data_directory
    type:
      - 'null'
      - Directory
    doc: data directory for files.
    inputBinding:
      position: 102
      prefix: --dir
  - id: update
    type:
      - 'null'
      - boolean
    doc: overwrite existing databases if present.
    inputBinding:
      position: 102
      prefix: --update
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaquantome:2.0.2--pyhdfd78af_0
stdout: metaquantome_db.out
