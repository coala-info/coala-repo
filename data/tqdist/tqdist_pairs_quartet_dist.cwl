cwlVersion: v1.2
class: CommandLineTool
baseCommand: tqdist_pairs_quartet_dist
label: tqdist_pairs_quartet_dist
doc: "The provided help text contains container build errors and does not provide
  usage information for the tool. tqdist_pairs_quartet_dist is typically used for
  computing quartet distances between pairs of phylogenetic trees.\n\nTool homepage:
  http://users-cs.au.dk/cstorm/software/tqdist/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tqdist:1.0.0--hfc679d8_1
stdout: tqdist_pairs_quartet_dist.out
