cwlVersion: v1.2
class: CommandLineTool
baseCommand: PathogenTrack
label: pathogentrack_PathogenTrack
doc: "A tool for counting microbes at single-cell levels, including trimming, extraction,
  filtering, alignment, classification, and quantification.\n\nTool homepage: https://github.com/ncrna/PathogenTrack"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to execute: count, trim, extract, filter, align, classify,
      or quant'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathogentrack:0.2.3--pyh5e36f6f_0
stdout: pathogentrack_PathogenTrack.out
