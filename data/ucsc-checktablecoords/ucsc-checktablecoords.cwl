cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkTableCoords
label: ucsc-checktablecoords
doc: "Check that table coordinates are within chromosome sizes.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: The database name (e.g., hg19).
    inputBinding:
      position: 1
  - id: table
    type: string
    doc: The table name to check.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-checktablecoords:482--h0b57e2e_0
stdout: ucsc-checktablecoords.out
