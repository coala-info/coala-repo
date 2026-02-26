cwlVersion: v1.2
class: CommandLineTool
baseCommand: quartet_dist
label: tqdist_quartet_dist
doc: "Calculates the quartet distance between two trees in Newick format. The quartet
  distance is printed to stdout.\n\nTool homepage: http://users-cs.au.dk/cstorm/software/tqdist/"
inputs:
  - id: filename1
    type: File
    doc: First file containing one tree in Newick format
    inputBinding:
      position: 1
  - id: filename2
    type: File
    doc: Second file containing one tree in Newick format
    inputBinding:
      position: 2
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: If used, reports additional numbers including number of leaves, number 
      of quartets, quartet distance, normalized quartet distance, and quartet 
      agreement/unresolved statistics
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
stdout: tqdist_quartet_dist.out
