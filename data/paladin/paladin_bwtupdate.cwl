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
  - id: updated_bwt
    type: File
    doc: The BWT file after the in-place update
    outputBinding:
      glob: $(inputs.bwt_file.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bwt_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
stdout: paladin_bwtupdate.out
