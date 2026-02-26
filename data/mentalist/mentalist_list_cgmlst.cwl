cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mentalist
  - list_cgmlst
label: mentalist_list_cgmlst
doc: "List available cgMLST schemes.\n\nTool homepage: https://github.com/WGS-TB/MentaLiST"
inputs:
  - id: prefix
    type:
      - 'null'
      - string
    doc: Only list schemes where the species name starts with this prefix.
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
stdout: mentalist_list_cgmlst.out
