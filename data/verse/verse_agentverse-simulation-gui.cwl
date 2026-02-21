cwlVersion: v1.2
class: CommandLineTool
baseCommand: verse_agentverse-simulation-gui
label: verse_agentverse-simulation-gui
doc: "AgentVerse simulation GUI tool (Note: The provided text contains container runtime
  logs and error messages rather than command-line help documentation. No arguments
  could be extracted.)\n\nTool homepage: https://github.com/OpenBMB/AgentVerse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verse:0.1.5--h577a1d6_9
stdout: verse_agentverse-simulation-gui.out
