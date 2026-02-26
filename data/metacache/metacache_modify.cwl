cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metacache
  - modify
label: metacache_modify
doc: "Modify a metacache database with new sequence files.\n\nTool homepage: https://github.com/muellan/metacache"
inputs:
  - id: database
    type: string
    doc: Name of the database to modify.
    inputBinding:
      position: 1
  - id: sequence_files
    type:
      type: array
      items: File
    doc: Sequence file or directory to add to the database.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
stdout: metacache_modify.out
