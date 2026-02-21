cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphmb
label: graphmb
doc: "GraphMB: Graph-based Metagenomic Binning\n\nTool homepage: https://github.com/MicrobialDarkMatter/GraphMB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphmb:0.2.5--pyh7cba7a3_0
stdout: graphmb.out
