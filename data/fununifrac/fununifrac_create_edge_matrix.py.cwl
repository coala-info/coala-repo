cwlVersion: v1.2
class: CommandLineTool
baseCommand: create_edge_matrix.py
label: fununifrac_create_edge_matrix.py
doc: "Given the KEGG hierarchy, first this will select the subtree consisting of all\n\
  the ancestors of the given brite_id. Then, it will create a matrix where the\n(i,j)
  entry will be 1 iff for the ith pair of KOs in the --distances file:\n(KO1, KO2),
  edge j is on the shortest path from KO1 to KO2\n\nTool homepage: https://github.com/KoslickiLab/FunUniFrac"
inputs:
  - id: edge_file
    type: File
    doc: Input edge list file of the KEGG hierarchy
    inputBinding:
      position: 101
      prefix: --edge_file
  - id: distance_file
    type: File
    doc: File containing all pairwise distances between KOs. Use sourmash compare
    secondaryFiles:
      - pattern: .labels.txt
        required: true
    inputBinding:
      position: 101
      prefix: --distance_file
  - id: brite_id
    type: string
    doc: Brite ID of the KEGG hierarchy you want to focus on. Eg. ko00001
    inputBinding:
      position: 101
      prefix: --brite_id
  - id: out_dir_path
    type: string
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --out_dir
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory with the edge matrix (fununifrac_A.npz) and its basis
    outputBinding:
      glob: $(inputs.out_dir_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.out_dir_path)
        entry: "$({class: 'Directory', basename: inputs.out_dir_path, listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fununifrac:0.0.1--pyh7cba7a3_0
