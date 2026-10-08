cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fio
  - ls
label: fiona_fio_ls
doc: "List layers in a datasource.\n\nTool homepage: https://github.com/Toblerity/Fiona"
inputs:
  - id: input
    type: File
    doc: Input datasource (for a shapefile, the .shx, .dbf, .prj and .cpg files are staged beside it)
    secondaryFiles:
      - pattern: ^.shx
        required: false
      - pattern: ^.dbf
        required: false
      - pattern: ^.prj
        required: false
      - pattern: ^.cpg
        required: false
    inputBinding:
      position: 1
  - id: indent
    type:
      - 'null'
      - int
    doc: Indentation level for JSON output
    inputBinding:
      position: 102
      prefix: --indent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiona:1.8.6
stdout: fiona_fio_ls.out
