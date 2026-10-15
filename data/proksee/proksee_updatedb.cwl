cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - proksee
  - updatedb
label: proksee_updatedb
doc: "Update the proksee database\n\nTool homepage: https://github.com/proksee-project/proksee-cmd"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: directory
    type:
      - 'null'
      - string
    doc: The directory to place the database files.
    inputBinding:
      position: 1
      prefix: -d
outputs:
  - id: database_directory
    type:
      - 'null'
      - Directory
    doc: Directory with the database files
    outputBinding:
      glob: $(inputs.directory)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proksee:1.0.0a2--pyhdfd78af_0
stdout: proksee_updatedb.out
