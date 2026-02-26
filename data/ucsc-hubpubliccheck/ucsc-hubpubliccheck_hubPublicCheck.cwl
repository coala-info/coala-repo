cwlVersion: v1.2
class: CommandLineTool
baseCommand: hubPublicCheck
label: ucsc-hubpubliccheck_hubPublicCheck
doc: "checks that the labels in hubPublic match what is in the hub labels\n   outputs
  SQL statements to put the table into compliance\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: table_name
    type: string
    doc: The name of the table to check
    inputBinding:
      position: 1
  - id: add_hub
    type:
      - 'null'
      - string
    doc: output statments to add url to table
    inputBinding:
      position: 102
      prefix: -addHub
  - id: udc_dir
    type:
      - 'null'
      - Directory
    doc: place to put cache for remote bigBed/bigWigs
    inputBinding:
      position: 102
      prefix: -udcDir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hubpubliccheck:482--h0b57e2e_0
stdout: ucsc-hubpubliccheck_hubPublicCheck.out
