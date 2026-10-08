cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dmtools
  - viewheader
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
  - id: header
    type: stderr
    doc: DM file header (the tool prints it to standard error)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
stderr: dmtools_viewheader.txt
