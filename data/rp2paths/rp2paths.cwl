cwlVersion: v1.2
class: CommandLineTool
baseCommand: rp2paths
label: rp2paths
doc: "A tool for processing RetroPath2.0 metabolic pathways.\n\nTool homepage: https://github.com/brsynth/rp2paths"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rp2paths:2.1.4
stdout: rp2paths.out
