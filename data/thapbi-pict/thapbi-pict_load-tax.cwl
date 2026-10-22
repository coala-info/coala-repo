cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - thapbi_pict
  - load-tax
label: thapbi-pict_load-tax
doc: "Load an NCBI taxonomy dump into a marker database.\n\nTool homepage: https://github.com/peterjc/thapbi-pict"
inputs:
  - id: tax
    type: Directory
    doc: "Folder containing NCBI taxonomy files `names.dmp` etc."
    inputBinding:
      position: 101
      prefix: -t
  - id: database
    type: string
    doc: "Which database to write to (or create)."
    inputBinding:
      position: 101
      prefix: -d
  - id: ancestors
    type:
      - 'null'
      - string
    doc: "Comma separated list of NCBI taxids at genus level or higher. Default is 4762 for Oomycetes, use 4776 for Peronosporales, or 4783 for Phytophthora only."
    inputBinding:
      position: 101
      prefix: -a
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose logging."
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: database_file
    type: File
    doc: "Marker database written"
    outputBinding:
      glob: $(inputs.database)
  - id: log
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
stdout: thapbi-pict_load-tax.out
