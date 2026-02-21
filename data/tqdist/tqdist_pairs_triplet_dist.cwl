cwlVersion: v1.2
class: CommandLineTool
baseCommand: tqdist_pairs_triplet_dist
label: tqdist_pairs_triplet_dist
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error message regarding a container build failure (Apptainer/Singularity)
  while attempting to fetch the tqdist image from a Docker registry.\n\nTool homepage:
  http://users-cs.au.dk/cstorm/software/tqdist/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tqdist:1.0.0--hfc679d8_1
stdout: tqdist_pairs_triplet_dist.out
