cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmtools_viewheader
label: dmtools_viewheader
doc: "View header of a DM file\n\nTool homepage: https://github.com/ZhouQiangwei/dmtools"
inputs:
  - id: input_dm_file
    type: File
    doc: input DM file
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
stdout: dmtools_viewheader.out
