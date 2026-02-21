cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmratac
label: hmmratac
doc: "HMM-based Analysis of ATAC-seq data (Note: The provided text contains only system
  error messages and no CLI usage information).\n\nTool homepage: https://github.com/LiuLabUB/HMMRATAC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmratac:1.2.10--hdfd78af_1
stdout: hmmratac.out
