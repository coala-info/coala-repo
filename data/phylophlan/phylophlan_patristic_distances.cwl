cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylophlan_patristic_distances
label: phylophlan_patristic_distances
doc: "Calculates the pairwise patristic (leaf-to-leaf) distance matrix from a phylogenetic tree. It runs efficiently in O^2 time and space and can be parallelized.\n\nTool homepage: https://github.com/biobakery/phylophlan"
inputs:
  - id: input_tree
    type: File
    doc: "Path to the tree file in Newick format"
    inputBinding:
      position: 1
      prefix: "--input_tree"
  - id: output_file
    type: string
    doc: "Output file to write the distance matrix to"
    inputBinding:
      position: 2
      prefix: "--output_file"
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output format (tsv, parquet, npy or tri); if not specified it is determined from the output_file extension"
    inputBinding:
      position: 3
      prefix: "--output_format"
  - id: nproc
    type:
      - 'null'
      - int
    doc: "Number of processes (default: 1)"
    inputBinding:
      position: 4
      prefix: "--nproc"
outputs:
  - id: distance_matrix
    type:
      - 'null'
      - type: array
        items: File
    doc: "Distance matrix (and the index file for the npy format)"
    outputBinding:
      glob:
        - "$(inputs.output_file)"
        - "$(inputs.output_file).index"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0
stdout: phylophlan_patristic_distances.out
