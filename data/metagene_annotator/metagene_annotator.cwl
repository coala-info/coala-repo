cwlVersion: v1.2
class: CommandLineTool
baseCommand: metagene_annotator
label: metagene_annotator
doc: "Metagene Annotator (MGA) is a tool for identifying genes in prokaryotic and
  phage genomes. (Note: The provided help text contains only container runtime error
  messages and does not list specific arguments.)\n\nTool homepage: http://metagene.cb.k.u-tokyo.ac.jp/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagene_annotator:1.0--0
stdout: metagene_annotator.out
