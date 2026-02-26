cwlVersion: v1.2
class: CommandLineTool
baseCommand: diphase_pipeline.py
label: diphase_pipeline.py
doc: "pipeline for phasing\n\nTool homepage: https://github.com/zhangjuncsu/Diphase"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand for phasing assembly type
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diphase:1.0.3--h739ee2d_0
stdout: diphase_pipeline.py.out
