cwlVersion: v1.2
class: CommandLineTool
baseCommand: all_pairs_triplet_dist
label: tqdist_all_pairs_triplet_dist
doc: "Calculates the pairwise triplet distance between all pairs of trees in a file.
  The output is a lower triangular matrix.\n\nTool homepage: http://users-cs.au.dk/cstorm/software/tqdist/"
inputs:
  - id: input_filename
    type: File
    doc: Name of a file containing multiple trees in Newick format. Each tree 
      should be on a separate line, with identical leaf labels across all trees.
    inputBinding:
      position: 1
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: The file to which the output is written. If not specified, output is 
      written to stdout.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tqdist:1.0.0--hfc679d8_1
