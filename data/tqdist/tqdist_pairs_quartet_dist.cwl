cwlVersion: v1.2
class: CommandLineTool
baseCommand: pairs_quartet_dist
label: tqdist_pairs_quartet_dist
doc: "Calculates the quartet distance between pairs of trees in two files. The files
  must contain the same number of trees in Newick format, and corresponding trees
  must have the same set of leaf labels.\n\nTool homepage: http://users-cs.au.dk/cstorm/software/tqdist/"
inputs:
  - id: filename1
    type: File
    doc: First file containing trees in Newick format
    inputBinding:
      position: 1
  - id: filename2
    type: File
    doc: Second file containing trees in Newick format
    inputBinding:
      position: 2
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: If used, reports detailed metrics for each pair of trees including 
      number of leaves, triplets, triplet distance, normalized distance, and 
      resolved/unresolved triplet counts
    inputBinding:
      position: 0
      prefix: -v
  - id: output_filename_path
    type:
      - 'null'
      - string
    doc: Name of a file to write the output to; if not specified, output is written
      to stdout.
    inputBinding:
      position: 3
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Output file, when an output filename is given
    outputBinding:
      glob: $(inputs.output_filename_path)
  - id: stdout
    type: stdout
    doc: Standard output (the distances when no output filename is given)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tqdist:1.0.0--hfc679d8_1
stdout: tqdist_pairs_quartet_dist.out
