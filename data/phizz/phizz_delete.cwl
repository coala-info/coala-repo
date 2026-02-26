cwlVersion: v1.2
class: CommandLineTool
baseCommand: phizz_delete
label: phizz_delete
doc: "Deletes the phizz database.\n\nTool homepage: https://github.com/moonso/phizz"
inputs:
  - id: database_path
    type: File
    doc: Path to the phizz database to delete.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phizz:0.2.3--py_0
stdout: phizz_delete.out
