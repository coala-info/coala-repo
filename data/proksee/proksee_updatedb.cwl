cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - proksee
  - updatedb
label: proksee_updatedb
doc: "Update the proksee database\n\nTool homepage: https://github.com/proksee-project/proksee-cmd"
inputs:
  - id: directory
    type: Directory
    doc: Directory to update the database in
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proksee:1.0.0a2--pyhdfd78af_0
stdout: proksee_updatedb.out
