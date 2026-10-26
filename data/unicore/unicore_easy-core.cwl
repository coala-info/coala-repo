cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicore
  - easy-core
label: unicore_easy-core
doc: |-
  Easy core gene phylogeny workflow, from fasta files to phylogenetic tree

  Tool homepage: https://github.com/steineggerlab/unicore
inputs:
  - id: input
    type: 
      - File
      - Directory
    doc: "Input directory with fasta files or a single fasta file"
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "Output directory where all results will be saved"
    inputBinding:
      position: 2
  - id: model
    type: Directory
    doc: "ProstT5 model (directory with the ProstT5 weights)"
    inputBinding:
      position: 3
  - id: tmp
    type: string
    doc: "tmp directory"
    inputBinding:
      position: 4
  - id: keep
    type: ['null', boolean]
    doc: "Keep intermediate files"
    inputBinding:
      position: 10
      prefix: --keep
  - id: overwrite
    type: ['null', boolean]
    doc: "Force overwrite output database"
    inputBinding:
      position: 10
      prefix: --overwrite
  - id: max_len
    type: ['null', int]
    doc: "Set maximum sequence length threshold"
    inputBinding:
      position: 10
      prefix: --max-len
  - id: gpu
    type: ['null', boolean]
    doc: "Use GPU for foldseek createdb"
    inputBinding:
      position: 10
      prefix: --gpu
  - id: afdb_lookup
    type: ['null', string]
    doc: "Use AFDB lookup for foldseek createdb. Useful for large databases"
    inputBinding:
      position: 10
      prefix: --afdb-lookup
  - id: custom_lookup
    type: ['null', string]
    doc: "Use custom lookup database, accepts any Foldseek database to reference against"
    inputBinding:
      position: 10
      prefix: --custom-lookup
  - id: cluster_options
    type: ['null', string]
    doc: "Arguments for foldseek options in string e.g. -c \"-c 0.8\" (default \"-c 0.8\")"
    inputBinding:
      position: 10
      prefix: --cluster-options
  - id: core_threshold
    type: ['null', int]
    doc: "Coverage threshold for core structures. [0 - 100] (default 80)"
    inputBinding:
      position: 10
      prefix: --core-threshold
  - id: print_copiness
    type: ['null', boolean]
    doc: "Generate tsv with copy number statistics"
    inputBinding:
      position: 10
      prefix: --print-copiness
  - id: aligner
    type: ['null', string]
    doc: "Multiple sequence aligner [foldmason, mafft-linsi, mafft] (default foldmason)"
    inputBinding:
      position: 10
      prefix: --aligner
  - id: no_inference
    type: ['null', boolean]
    doc: "Stop the tree module after alignment (before tree inference)"
    inputBinding:
      position: 10
      prefix: --no-inference
  - id: tree_builder
    type: ['null', string]
    doc: "Phylogenetic tree builder [iqtree, fasttree, raxml-ng] (default iqtree)"
    inputBinding:
      position: 10
      prefix: --tree-builder
  - id: aligner_options
    type: ['null', string]
    doc: "Options for sequence aligner"
    inputBinding:
      position: 10
      prefix: --aligner-options
  - id: tree_options
    type: ['null', string]
    doc: "Options for tree builder; if not given: iqtree: -m JTT+F+I+G -B 1000; fasttree: -gamma -boot 1000; raxml-ng: --model JTT+F+I+G --seed 12345 --all --tree pars{90},rand{10}"
    inputBinding:
      position: 10
      prefix: --tree-options
  - id: gap_threshold
    type: ['null', int]
    doc: "Gap threshold for multiple sequence alignment [0 - 100] (default 50)"
    inputBinding:
      position: 10
      prefix: --gap-threshold
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use; 0 to use all (default 0)"
    inputBinding:
      position: 10
      prefix: --threads
  - id: verbosity
    type: ['null', int]
    doc: "Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug) (default 3)"
    inputBinding:
      position: 10
      prefix: --verbosity
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory with all results
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
