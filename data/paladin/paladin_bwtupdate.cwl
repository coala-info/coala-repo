cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - paladin
  - bwtupdate
label: paladin_bwtupdate
doc: "Update a BWT index for PALADIN\n\nTool homepage: https://github.com/ToniWestbrook/paladin"
inputs:
  - id: bwt_file
    type: File
    doc: The BWT file to update
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
stdout: paladin_bwtupdate.out
