cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - bwtupdate
label: bwa_bwtupdate
doc: "Update the BWT (Burrows-Wheeler Transform) file.\n\nTool homepage: https://github.com/lh3/bwa"
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
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
stdout: bwa_bwtupdate.out
