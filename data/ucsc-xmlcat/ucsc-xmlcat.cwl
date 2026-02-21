cwlVersion: v1.2
class: CommandLineTool
baseCommand: xmlCat
label: ucsc-xmlcat
doc: "Concatenate XML files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: xml_files
    type:
      type: array
      items: File
    doc: XML files to be concatenated
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-xmlcat:482--h0b57e2e_0
stdout: ucsc-xmlcat.out
