cwlVersion: v1.2
class: CommandLineTool
baseCommand: arborist
label: arborist
doc: "Arborist: a method to rank SNV clonal trees using scDNA-seq data.\n\nTool homepage:
  https://github.com/VanLoo-lab/Arborist"
inputs:
  - id: add_normal
    type:
      - 'null'
      - boolean
    doc: flag to add a normal clone if input trees do not already contain them
    inputBinding:
      position: 101
      prefix: --add-normal
  - id: alpha
    type:
      - 'null'
      - float
    doc: Per base sequencing error
    inputBinding:
      position: 101
      prefix: --alpha
  - id: edge_delim
    type:
      - 'null'
      - string
    doc: edge delimiter in candidate tree file.
    inputBinding:
      position: 101
      prefix: --edge-delim
  - id: max_iter
    type:
      - 'null'
      - int
    doc: max number of iterations
    inputBinding:
      position: 101
      prefix: --max-iter
  - id: pickle
    type:
      - 'null'
      - File
    doc: path to where all pickled tree fits should be saved.
    inputBinding:
      position: 101
      prefix: --pickle
  - id: prior
    type:
      - 'null'
      - float
    doc: prior (gamma) on input SNV cluster assignment
    inputBinding:
      position: 101
      prefix: --prior
  - id: read_counts
    type: File
    doc: Path to read counts CSV file with columns 'snv', 'cell', 'total', 'alt'
    inputBinding:
      position: 101
      prefix: --read_counts
  - id: snv_clusters
    type: File
    doc: Path to SNV clusters CSV file with unlabeled columns 'snv', 'cluster'. 
      The order of columns matters
    inputBinding:
      position: 101
      prefix: --snv-clusters
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: trees
    type: File
    doc: Path to file containing all candidate trees to be ranked.
    inputBinding:
      position: 101
      prefix: --trees
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: draw
    type:
      - 'null'
      - File
    doc: Path to where the tree visualization should be saved
    outputBinding:
      glob: $(inputs.draw)
  - id: tree
    type:
      - 'null'
      - File
    doc: Path to save the top ranked tree as a txt file.
    outputBinding:
      glob: $(inputs.tree)
  - id: ranking
    type:
      - 'null'
      - File
    doc: Path to where tree ranking output should be saved
    outputBinding:
      glob: $(inputs.ranking)
  - id: cell_assign
    type:
      - 'null'
      - File
    doc: Path to where the MAP cell-to-clone labels should be saved
    outputBinding:
      glob: $(inputs.cell_assign)
  - id: snv_assign
    type:
      - 'null'
      - File
    doc: Path to where the MAP SNV-to-cluster labels should be saved.
    outputBinding:
      glob: $(inputs.snv_assign)
  - id: q_y
    type:
      - 'null'
      - File
    doc: Path to where the approximate SNV posterior should be saved
    outputBinding:
      glob: $(inputs.q_y)
  - id: q_z
    type:
      - 'null'
      - File
    doc: Path to where the approximate cell posterior should be saved
    outputBinding:
      glob: $(inputs.q_z)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arborist:1.0.0--pyhdfd78af_0
