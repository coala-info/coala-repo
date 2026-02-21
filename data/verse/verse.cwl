cwlVersion: v1.2
class: CommandLineTool
baseCommand: verse
label: verse
doc: "VERSE (Versatile Estimation of RNA-Seq Expression) is a tool for quantifying
  gene expression from RNA-Seq data.\n\nTool homepage: https://github.com/OpenBMB/AgentVerse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verse:0.1.5--h577a1d6_9
stdout: verse.out
