cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmratac
label: hmmratac_HMMRATAC_V1.2.10_exe.jar
doc: "HMMRATAC is a dedicated software package for identifying and characterizing
  open chromatin regions from ATAC-seq data.\n\nTool homepage: https://github.com/LiuLabUB/HMMRATAC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmratac:1.2.10--hdfd78af_1
stdout: hmmratac_HMMRATAC_V1.2.10_exe.jar.out
