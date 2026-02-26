cwlVersion: v1.2
class: CommandLineTool
baseCommand: triplet_dist
label: tqdist_triplet_dist
doc: "Calculate the triplet distance between two trees in Newick format. The triplet
  distance between the two trees will be printed to stdout.\n\nTool homepage: http://users-cs.au.dk/cstorm/software/tqdist/"
inputs:
  - id: tree_file_1
    type: File
    doc: File containing the first tree in Newick format.
    inputBinding:
      position: 1
  - id: tree_file_2
    type: File
    doc: File containing the second tree in Newick format.
    inputBinding:
      position: 2
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: If used, reports detailed numbers including leaf count, triplet count, 
      distance, normalized distance, and resolved/unresolved triplet statistics.
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tqdist:1.0.0--hfc679d8_1
stdout: tqdist_triplet_dist.out
