cwlVersion: v1.2
class: CommandLineTool
baseCommand: tqdist_all_pairs_triplet_dist
label: tqdist_all_pairs_triplet_dist
doc: "The provided text does not contain help information for the tool; it contains
  container engine logs and a fatal error during image retrieval.\n\nTool homepage:
  http://users-cs.au.dk/cstorm/software/tqdist/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tqdist:1.0.0--hfc679d8_1
stdout: tqdist_all_pairs_triplet_dist.out
