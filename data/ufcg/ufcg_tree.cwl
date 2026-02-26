cwlVersion: v1.2
class: CommandLineTool
baseCommand: ufcg tree
label: ufcg_tree
doc: "Reconstruct the phylogenetic relationship with UFCG profiles\n\nTool homepage:
  https://ufcg.steineggerlab.com"
inputs:
  - id: align_multiple_copied_genes
    type:
      - 'null'
      - boolean
    doc: Align multiple copied genes
    inputBinding:
      position: 101
      prefix: -c
  - id: alignment_method
    type:
      - 'null'
      - string
    doc: Alignment method {nucleotide, codon, codon12, protein}
    default: protein
    inputBinding:
      position: 101
      prefix: -a
  - id: continue_from_checkpoint
    type:
      - 'null'
      - boolean
    doc: Continue from the checkpoint
    inputBinding:
      position: 101
      prefix: -k
  - id: developer_mode
    type:
      - 'null'
      - boolean
    doc: Activate developer mode (For testing or debugging)
    inputBinding:
      position: 101
      prefix: --developer
  - id: fasttree_binary
    type:
      - 'null'
      - File
    doc: Path to FastTree binary
    default: FastTree
    inputBinding:
      position: 101
      prefix: --fasttree
  - id: gap_rich_filter_percentage
    type:
      - 'null'
      - int
    doc: Gap-rich filter percentage threshold {0 - 100}
    default: 50
    inputBinding:
      position: 101
      prefix: -f
  - id: gsi_threshold
    type:
      - 'null'
      - int
    doc: GSI value threshold {1 - 100}
    default: 95
    inputBinding:
      position: 101
      prefix: -g
  - id: input_profiles_dir
    type: Directory
    doc: Input directory containing UFCG profiles
    inputBinding:
      position: 101
      prefix: -i
  - id: iqtree_binary
    type:
      - 'null'
      - File
    doc: Path to IQ-TREE binary
    default: iqtree
    inputBinding:
      position: 101
      prefix: --iqtree
  - id: leaf_format
    type:
      - 'null'
      - string
    doc: 'Tree leaf format, comma-separated string containing one or more of the following
      keywords: {label} {uid, acc, label, taxon, strain, type, taxonomy}'
    inputBinding:
      position: 101
      prefix: -l
  - id: mafft_binary
    type:
      - 'null'
      - File
    doc: Path to MAFFT binary
    default: mafft-linsi
    inputBinding:
      position: 101
      prefix: --mafft
  - id: max_gene_tree_executors
    type:
      - 'null'
      - int
    doc: Maximum number of gene tree executors; lower this if the RAM usage is 
      excessive {1 - threads}
    inputBinding:
      position: 101
      prefix: -x
  - id: ml_tree_inference_model
    type:
      - 'null'
      - string
    doc: ML tree inference model {JTT+ (proteins); GTR+ (nucleotides)}
    inputBinding:
      position: 101
      prefix: -m
  - id: no_color
    type:
      - 'null'
      - boolean
    doc: Remove ANSI escapes from standard output
    inputBinding:
      position: 101
      prefix: --nocolor
  - id: no_time
    type:
      - 'null'
      - boolean
    doc: Remove timestamp in front of the prompt string
    inputBinding:
      position: 101
      prefix: --notime
  - id: raxml_binary
    type:
      - 'null'
      - File
    doc: Path to RAxML binary
    default: raxmlHPC-PTHREADS
    inputBinding:
      position: 101
      prefix: --raxml
  - id: run_name
    type:
      - 'null'
      - string
    doc: Name of this run
    default: tree
    inputBinding:
      position: 101
      prefix: -n
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: -t
  - id: tree_building_program
    type:
      - 'null'
      - string
    doc: Tree building program {raxml, iqtree, fasttree}
    default: iqtree
    inputBinding:
      position: 101
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Make program verbose
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ufcg:1.0.6--hdfd78af_0
