cwlVersion: v1.2
class: CommandLineTool
baseCommand: verse
label: verse_agentverse-tasksolving
doc: "VERSE (Versatile Evaluation of RNA-seq Expression) is a tool for annotating
  and quantifying RNA-seq reads.\n\nTool homepage: https://github.com/OpenBMB/AgentVerse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verse:0.1.5--h577a1d6_9
stdout: verse_agentverse-tasksolving.out
