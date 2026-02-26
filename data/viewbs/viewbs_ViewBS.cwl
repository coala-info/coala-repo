cwlVersion: v1.2
class: CommandLineTool
baseCommand: ViewBS
label: viewbs_ViewBS
doc: "Tools for exploring and visualizing deep sequencing of bisulfite seuquencing
  (BS-seq) data.\n\nTool homepage: https://github.com/xie186/ViewBS"
inputs:
  - id: subcmd
    type: string
    doc: Subcommand to execute
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viewbs:0.1.11--pl5321h7b50bb2_4
stdout: viewbs_ViewBS.out
