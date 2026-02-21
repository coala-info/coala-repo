cwlVersion: v1.2
class: CommandLineTool
baseCommand: tqdist_triplet_dist
label: tqdist_triplet_dist
doc: "A tool for computing the triplet distance between phylogenetic trees. (Note:
  The provided help text contains only system error messages and no usage information.)\n
  \nTool homepage: http://users-cs.au.dk/cstorm/software/tqdist/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tqdist:1.0.0--hfc679d8_1
stdout: tqdist_triplet_dist.out
