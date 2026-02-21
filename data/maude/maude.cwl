cwlVersion: v1.2
class: CommandLineTool
baseCommand: maude
label: maude
doc: "MAUDE (Mean Alteration of Uniplexed Deletions) is a tool for analyzing CRISPR
  screens.\n\nTool homepage: https://github.com/maude-lang/Maude"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maude:v2.7-2b1-deb_cv1
stdout: maude.out
