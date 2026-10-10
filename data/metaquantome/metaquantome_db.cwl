cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metaquantome
  - db
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
    type: string
    default: metaquantome_data
    doc: data directory for files (created by the tool; collected as an output).
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
  - id: data_directory_dir
    type: Directory
    doc: Folder with the downloaded databases
    outputBinding:
      glob: $(inputs.data_directory)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.data_directory)
        entry: "$({class: 'Directory', basename: inputs.data_directory, listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaquantome:2.0.2--pyhdfd78af_0
stdout: metaquantome_db.out
