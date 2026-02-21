cwlVersion: v1.2
class: CommandLineTool
baseCommand: dna_features_viewer
label: dna_features_viewer
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image conversion and disk
  space.\n\nTool homepage: https://github.com/Edinburgh-Genome-Foundry/DnaFeaturesViewer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dna_features_viewer:3.1.5--pyh7e72e81_0
stdout: dna_features_viewer.out
