cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadOut
label: ucsc-hgloadout_hgLoadOut
doc: "load RepeatMasker .out files into database\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
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
    doc: RepeatMasker .out file(s)
    inputBinding:
      position: 2
  - id: split
    type:
      - 'null'
      - boolean
    doc: load chrN_rmsk separate tables even if a single file is given
    inputBinding:
      position: 103
      prefix: -split
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
    doc: use a different suffix other than the default (rmsk)
    inputBinding:
      position: 103
      prefix: -table
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadout:482--h0b57e2e_0
stdout: ucsc-hgloadout_hgLoadOut.out
