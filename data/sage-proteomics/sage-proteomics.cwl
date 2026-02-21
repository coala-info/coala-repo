cwlVersion: v1.2
class: CommandLineTool
baseCommand: sage
label: sage-proteomics
doc: "Sage is a search engine for shotgun proteomics, capable of searching MS2 spectra
  against a protein database.\n\nTool homepage: https://github.com/lazear/sage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sage-proteomics:0.14.7--hc1c3326_2
stdout: sage-proteomics.out
