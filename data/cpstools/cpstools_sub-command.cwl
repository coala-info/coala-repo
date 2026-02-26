cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpstools
label: cpstools_sub-command
doc: "A collection of tools for analyzing sequence data.\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: sub_command
    type: string
    doc: 'The sub-command to run. Available choices: gbcheck, info, Seq, IR, Pi, RSCU,
      SSRs, convert, LSRs, phy, KaKs, exc, GC, depth'
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_sub-command.out
