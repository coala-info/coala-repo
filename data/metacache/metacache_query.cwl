cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacache query
label: metacache_query
doc: "Query a metacache database with sequence files or directories.\n\nTool homepage:
  https://github.com/muellan/metacache"
inputs:
  - id: database
    type: File
    doc: Database filename
    inputBinding:
      position: 1
  - id: sequence_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Sequence file or directory
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
stdout: metacache_query.out
