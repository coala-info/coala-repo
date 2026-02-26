cwlVersion: v1.2
class: CommandLineTool
baseCommand: hsp.py
label: picrust2_hsp.py
doc: "Calculates the functional profile of a microbial community based on a phylogenetic
  tree and marker gene information.\n\nTool homepage: https://github.com/picrust/picrust2"
inputs:
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check the input files and database integrity.
    inputBinding:
      position: 101
      prefix: --check
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Size of chunks for parallel processing.
    inputBinding:
      position: 101
      prefix: --chunk_size
  - id: database
    type:
      - 'null'
      - string
    doc: Path to the functional database.
    inputBinding:
      position: 101
      prefix: --database
  - id: edge_exponent
    type:
      - 'null'
      - float
    doc: Exponent for edge weighting in the phylogenetic tree.
    inputBinding:
      position: 101
      prefix: --edge_exponent
  - id: marker_type
    type:
      - 'null'
      - string
    doc: 'Type of marker genes to use for functional prediction. Options include:
      16S, BIGG, CAZY, EC, GENE_NAMES, GO, KO, PFAM, COG, TIGRFAM, PHENO.'
    default: 16S
    inputBinding:
      position: 101
      prefix: --marker_type
  - id: method
    type:
      - 'null'
      - string
    doc: 'Method for functional prediction. Options include: mp, emp_prob, pic, scp,
      subtree_average.'
    default: mp
    inputBinding:
      position: 101
      prefix: --method
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Normalize the functional profile.
    inputBinding:
      position: 101
      prefix: --normalize
  - id: observed_trait_table
    type:
      - 'null'
      - File
    doc: Path to a table of observed traits for trait-based prediction.
    inputBinding:
      position: 101
      prefix: --observed_trait_table
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of parallel processes to use.
    inputBinding:
      position: 101
      prefix: --processes
  - id: reference
    type:
      - 'null'
      - File
    doc: Path to the reference file for marker gene annotation.
    inputBinding:
      position: 101
      prefix: --reference
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility.
    inputBinding:
      position: 101
      prefix: --seed
  - id: tree
    type: File
    doc: Path to the input phylogenetic tree file.
    inputBinding:
      position: 101
      prefix: --tree
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: Path to the output file for the functional profile.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
