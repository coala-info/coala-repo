cwlVersion: v1.2
class: CommandLineTool
baseCommand: mga
label: metagene_annotator_mga
doc: "MetaGeneAnnotator (mga) is a tool for identifying genes in metagenomic sequences.
  Note: The provided help text contains a system error message regarding container
  execution and does not list command-line arguments.\n\nTool homepage: http://metagene.cb.k.u-tokyo.ac.jp/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagene_annotator:1.0--0
stdout: metagene_annotator_mga.out
