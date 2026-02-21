cwlVersion: v1.2
class: CommandLineTool
baseCommand: verse
label: verse_agentverse-simulation
doc: "VERSE (Versatile Evaluation of RNA-seq Expression) is a tool for quantifying
  gene expression from RNA-seq data. Note: The provided text appears to be a container
  build log rather than a help menu, so no arguments could be extracted.\n\nTool homepage:
  https://github.com/OpenBMB/AgentVerse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verse:0.1.5--h577a1d6_9
stdout: verse_agentverse-simulation.out
