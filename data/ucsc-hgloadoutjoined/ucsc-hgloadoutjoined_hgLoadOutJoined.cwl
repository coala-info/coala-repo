cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadOutJoined
label: ucsc-hgloadoutjoined_hgLoadOutJoined
doc: "load new style (2014) RepeatMasker .out files into database\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: database
    type: string
    doc: Database to load into
    inputBinding:
      position: 1
  - id: files
    type:
      type: array
      items: File
    doc: Input .out files
    inputBinding:
      position: 2
  - id: tab_file
    type:
      - 'null'
      - File
    doc: don't actually load database, just create tab file
    inputBinding:
      position: 103
      prefix: -tabFile
  - id: table
    type:
      - 'null'
      - string
    doc: use a different suffix other than the default (rmskOutBaseline)
    inputBinding:
      position: 103
      prefix: -table
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadoutjoined:482--h0b57e2e_0
stdout: ucsc-hgloadoutjoined_hgLoadOutJoined.out
