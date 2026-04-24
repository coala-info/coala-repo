cwlVersion: v1.2
class: CommandLineTool
baseCommand: unicore easy-core
label: unicore_easy-core
doc: "Easy core gene phylogeny workflow, from fasta files to phylogenetic tree\n\n\
  Tool homepage: https://github.com/steineggerlab/unicore"
inputs:
  - id: input
    type: string
    doc: Input directory with fasta files or a single fasta file
    inputBinding:
      position: 1
  - id: output
    type: Directory
    doc: Output directory where all results will be saved
    inputBinding:
      position: 2
  - id: model
    type: string
    doc: ProstT5 model
    inputBinding:
      position: 3
  - id: tmp
    type: Directory
    doc: tmp directory
    inputBinding:
      position: 4
  - id: afdb_lookup
    type:
      - 'null'
      - string
    doc: Use AFDB lookup for foldseek createdb. Useful for large databases
    inputBinding:
      position: 105
      prefix: --afdb-lookup
  - id: aligner
    type:
      - 'null'
      - string
    doc: Multiple sequence aligner [foldmason, mafft-linsi, mafft]
    inputBinding:
      position: 105
      prefix: --aligner
  - id: aligner_options
    type:
      - 'null'
      - string
    doc: Options for sequence aligner
    inputBinding:
      position: 105
      prefix: --aligner-options
  - id: cluster_options
    type:
      - 'null'
      - string
    doc: Arguments for foldseek options in string e.g. -c "-c 0.8"
    inputBinding:
      position: 105
      prefix: --cluster-options
  - id: core_threshold
    type:
      - 'null'
      - int
    doc: Coverage threshold for core structures. [0 - 100]
    inputBinding:
      position: 105
      prefix: --core-threshold
  - id: custom_lookup
    type:
      - 'null'
      - string
    doc: Use custom lookup database, accepts any Foldseek database to reference 
      against
    inputBinding:
      position: 105
      prefix: --custom-lookup
  - id: gap_threshold
    type:
      - 'null'
      - int
    doc: Gap threshold for multiple sequence alignment [0 - 100]
    inputBinding:
      position: 105
      prefix: --gap-threshold
  - id: gpu
    type:
      - 'null'
      - boolean
    doc: Use GPU for foldseek createdb
    inputBinding:
      position: 105
      prefix: --gpu
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files
    inputBinding:
      position: 105
      prefix: --keep
  - id: max_len
    type:
      - 'null'
      - int
    doc: Set maximum sequence length threshold
    inputBinding:
      position: 105
      prefix: --max-len
  - id: no_inference
    type:
      - 'null'
      - boolean
    doc: Stop the tree module after alignment (before tree inference)
    inputBinding:
      position: 105
      prefix: --no-inference
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwrite output database
    inputBinding:
      position: 105
      prefix: --overwrite
  - id: print_copiness
    type:
      - 'null'
      - boolean
    doc: Generate tsv with copy number statistics
    inputBinding:
      position: 105
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use; 0 to use all
    inputBinding:
      position: 105
      prefix: --threads
  - id: tree_builder
    type:
      - 'null'
      - string
    doc: Phylogenetic tree builder [iqtree, fasttree, raxml-ng]
    inputBinding:
      position: 105
      prefix: --tree-builder
  - id: tree_options
    type:
      - 'null'
      - string
    doc: "Options for tree builder; If not given, following options will be applied:\n\
      iqtree:   -m JTT+F+I+G -B 1000\nfasttree: -gamma -boot 1000\nraxml-ng: --model
      JTT+F+I+G --seed 12345 --all --tree pars{90},rand{10}"
    inputBinding:
      position: 105
      prefix: --tree-options
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug)'
    inputBinding:
      position: 105
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
stdout: unicore_easy-core.out
