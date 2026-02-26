cwlVersion: v1.2
class: CommandLineTool
baseCommand: place_seqs.py
label: picrust2_place_seqs.py
doc: "Place query sequences onto a reference tree and generate a new tree.\n\nTool
  homepage: https://github.com/picrust/picrust2"
inputs:
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Size of chunks for processing large datasets.
    inputBinding:
      position: 101
      prefix: --chunk_size
  - id: intermediate_path
    type:
      - 'null'
      - Directory
    doc: Path to store intermediate files.
    inputBinding:
      position: 101
      prefix: --intermediate
  - id: min_align
    type:
      - 'null'
      - int
    doc: Minimum alignment length to consider for placement.
    inputBinding:
      position: 101
      prefix: --min_align
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes to use for parallel computation.
    inputBinding:
      position: 101
      prefix: --processes
  - id: reference_tree
    type:
      - 'null'
      - File
    doc: Path to the reference tree file (e.g., Newick format).
    inputBinding:
      position: 101
      prefix: --reference_tree
  - id: study_fasta
    type: File
    doc: Path to the FASTA file containing the query sequences.
    inputBinding:
      position: 101
      prefix: --study_fasta
  - id: tree_type
    type:
      - 'null'
      - string
    doc: Type of tree to use for placement (epa-ng or sepp).
    default: epa-ng
    inputBinding:
      position: 101
      prefix: --tree_type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_tree
    type: File
    doc: Path to save the output tree file.
    outputBinding:
      glob: $(inputs.out_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picrust2:2.6.3--pyhdfd78af_1
