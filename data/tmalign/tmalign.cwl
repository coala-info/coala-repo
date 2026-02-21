cwlVersion: v1.2
class: CommandLineTool
baseCommand: tmalign
label: tmalign
doc: "TM-align is an algorithm for protein structure alignment. (Note: The provided
  help text contains only system error logs and no usage information; therefore, no
  arguments could be extracted.)\n\nTool homepage: https://zhanglab.ccmb.med.umich.edu/TM-align/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tmalign:20220227--h9948957_0
stdout: tmalign.out
