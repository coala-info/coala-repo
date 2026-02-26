cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcgtree.pl
label: bcgtree
doc: "Bacterial Phylogenomic Tree construction from genome sequences. The tool identifies
  core genes, aligns them, and constructs a phylogenetic tree.\n\nTool homepage: https://github.com/molbiodiv/bcgtree"
inputs:
  - id: bootstrap
    type:
      - 'null'
      - int
    doc: Number of bootstrap replicates for tree construction
    inputBinding:
      position: 101
      prefix: --bootstrap
  - id: check_installed
    type:
      - 'null'
      - boolean
    doc: Check if all required external software is installed
    inputBinding:
      position: 101
      prefix: --check-installed
  - id: genome
    type:
      type: array
      items: File
    doc: Input genome file(s) in FASTA or GenBank format (can be used multiple 
      times)
    inputBinding:
      position: 101
      prefix: --genome
  - id: min_genes
    type:
      - 'null'
      - int
    doc: Minimum number of genes that must be present in a genome to be included
    inputBinding:
      position: 101
      prefix: --min-genes
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: Prefix for the output files
    inputBinding:
      position: 101
      prefix: --out-prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel processing
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outdir
    type: Directory
    doc: Output directory for all results
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcgtree:1.2.1--pl5321hdfd78af_0
