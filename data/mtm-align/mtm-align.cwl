cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtm-align
label: mtm-align
doc: "mTM-align (multiple protein structure alignment) is a tool for aligning multiple
  protein structures to identify structural similarities.\n\nTool homepage: http://yanglab.nankai.edu.cn/mTM-align/help/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtm-align:20220104--h9948957_3
stdout: mtm-align.out
