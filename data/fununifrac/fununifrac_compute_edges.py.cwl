cwlVersion: v1.2
class: CommandLineTool
baseCommand: compute_edges.py
label: fununifrac_compute_edges.py
doc: "This will take the matrix made by graph_to_path_matrix.py and the all pairwise\n\
  distance matrix and solve the least squares problem of inferring the edge\nlengths
  of the graph.\n\nTool homepage: https://github.com/KoslickiLab/FunUniFrac"
inputs:
  - id: brite_id
    type: string
    doc: "Brite ID of the KEGG hierarchy you want to focus on.\n                 \
      \       Eg. ko00001"
    inputBinding:
      position: 101
      prefix: --brite_id
  - id: distance
    type:
      - 'null'
      - boolean
    doc: "Flag indicating that the input matrix is a distance\n                  \
      \      (0=identical). If not, it is assumed to be a\n                      \
      \  similarity (1=identical)."
    inputBinding:
      position: 101
      prefix: --distance
  - id: distance_file
    type: File
    doc: "File containing all pairwise distances between KOs.\n                  \
      \      Use sourmash compare"
    inputBinding:
      position: 101
      prefix: --distance_file
  - id: edge_file
    type: File
    doc: Input edge list file of the KEGG hierarchy
    inputBinding:
      position: 101
      prefix: --edge_file
  - id: factor
    type:
      - 'null'
      - float
    doc: "Selects <--factor>*(A.shape[1]) rows for which to do\n                 \
      \       the NNLS"
    inputBinding:
      position: 101
      prefix: --factor
  - id: num_iter
    type:
      - 'null'
      - int
    doc: "Number of random selections on which to perform the\n                  \
      \      NNLS"
    inputBinding:
      position: 101
      prefix: --num_iter
  - id: out_id
    type:
      - 'null'
      - string
    doc: "Test purpose: give an identifier to the output file so\n               \
      \         that tester can recognize it"
    inputBinding:
      position: 101
      prefix: --out_id
  - id: reg_factor
    type:
      - 'null'
      - float
    doc: Regularization factor for the NNLS
    inputBinding:
      position: 101
      prefix: --reg_factor
outputs:
  - id: out_dir
    type: Directory
    doc: "Output directory: the location to place the output\n                   \
      \     file with edge list with lengths in the last column"
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fununifrac:0.0.1--pyh7cba7a3_0
