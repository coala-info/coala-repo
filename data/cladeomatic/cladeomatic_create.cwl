cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cladeomatic
  - create
label: cladeomatic_create
doc: "Create a clade from a phylogenetic tree and a set of sequences.\n\nTool homepage:
  https://github.com/phac-nml/cladeomatic"
inputs:
  - id: tree_file
    type: File
    doc: Path to the phylogenetic tree file (e.g., Newick format).
    inputBinding:
      position: 1
  - id: sequences_file
    type: File
    doc: Path to the sequences file (e.g., FASTA format).
    inputBinding:
      position: 2
  - id: clade_name
    type:
      - 'null'
      - string
    doc: Name for the created clade.
    inputBinding:
      position: 103
      prefix: --clade-name
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum depth of the tree to consider for clade creation.
    inputBinding:
      position: 103
      prefix: --max-depth
  - id: min_support
    type:
      - 'null'
      - float
    doc: Minimum bootstrap support value to consider a clade.
    inputBinding:
      position: 103
      prefix: --min-support
  - id: output_dir
    type: Directory
    doc: Directory to save the created clade files.
    inputBinding:
      position: 103
      prefix: --output-dir
  - id: sequence_id_prefix
    type:
      - 'null'
      - string
    doc: Prefix to use for sequence IDs in the output files.
    inputBinding:
      position: 103
      prefix: --sequence-id-prefix
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cladeomatic:0.1.1--pyhdfd78af_0
stdout: cladeomatic_create.out
