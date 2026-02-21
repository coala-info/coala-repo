cwlVersion: v1.2
class: CommandLineTool
baseCommand: stamp
label: stamp
doc: "Statistical Analysis of Metagenomic Profiles (STAMP) is a graphical software
  package for analyzing taxonomic and functional profiles.\n\nTool homepage: https://github.com/stampit-org/stampit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stamp:2.1.3--py27_0
stdout: stamp.out
