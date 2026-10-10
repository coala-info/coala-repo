cwlVersion: v1.2
class: CommandLineTool
baseCommand: [metasbt, db]
label: metasbt_db
doc: "List and retrieve public MetaSBT databases.\n\nTool homepage: https://github.com/cumbof/MetaSBT"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.folder)
        entry: "$({class: 'Directory', basename: inputs.folder, listing: []})"
        writable: true
inputs:
  - id: list
    type:
      - 'null'
      - boolean
    doc: "List official public MetaSBT databases. (default: False)"
    inputBinding:
      position: 101
      prefix: "--list"
  - id: download
    type:
      - 'null'
      - string
    doc: "The database name."
    inputBinding:
      position: 101
      prefix: "--download"
  - id: version
    type:
      - 'null'
      - string
    doc: "The database version. It automatically select the most recent one if a version is not provided."
    inputBinding:
      position: 101
      prefix: "--version"
  - id: folder
    type:
      - 'null'
      - string
    doc: "Store the selected database under this folder (created before the run). (default: /tmp)"
    default: "metasbt_db"
    inputBinding:
      position: 101
      prefix: "--folder"
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: database_folder
    type: Directory
    doc: "Folder with the downloaded database"
    outputBinding:
      glob: "$(inputs.folder)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
    dockerOutputDirectory: /metasbt_work
stdout: metasbt_db.out
