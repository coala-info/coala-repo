cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scarap
  - core
label: scarap_core
doc: "Infer a core genome from a set of faa files.\n\nTool homepage: https://github.com/SWittouck/SCARAP"
inputs:
  - id: faa_files
    type: Directory
    doc: "Folder with one fasta file with amino acid sequences (faa file) per genome"
    inputBinding:
      position: 1
  - id: outfolder_path
    type: string
    doc: "Output folder"
    inputBinding:
      position: 2
  - id: method
    type:
      - 'null'
      - string
    doc: "Pangenome inference method (H, FH, FT, H-nl, T-nl, P, O-B, O-D, S; default FH)"
    inputBinding:
      position: 103
      prefix: --method
  - id: min_reps
    type:
      - 'null'
      - int
    doc: "Minimum number of representative sequences to use for multiple sequence alignment (default 32)"
    inputBinding:
      position: 104
      prefix: --min-reps
  - id: max_reps
    type:
      - 'null'
      - int
    doc: "Maximum number of representative sequences to use for multiple sequence alignment (default MIN_REPS * 1.25)"
    inputBinding:
      position: 105
      prefix: --max-reps
  - id: max_align
    type:
      - 'null'
      - int
    doc: "Maximum number of sequences to use for multiple sequence alignment (default MAX_REPS * 16)"
    inputBinding:
      position: 106
      prefix: --max-align
  - id: seeds
    type:
      - 'null'
      - int
    doc: "Number of seed genomes to use (default 100)"
    inputBinding:
      position: 110
      prefix: --seeds
  - id: core_prefilter
    type:
      - 'null'
      - float
    doc: "Minimum relative frequency of single-copy presence to be used for initial database construction"
    inputBinding:
      position: 107
      prefix: --core-prefilter
  - id: core_filter
    type:
      - 'null'
      - float
    doc: "Minimum relative frequency of single-copy presence to be used for the final selection"
    inputBinding:
      position: 108
      prefix: --core-filter
  - id: max_core_genes
    type:
      - 'null'
      - int
    doc: "Maximum number of core genes to retrieve (0 = no maximum, default 0)"
    inputBinding:
      position: 109
      prefix: --max-core-genes
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use"
    inputBinding:
      position: 101
      prefix: --threads
  - id: cont
    type:
      - 'null'
      - boolean
    doc: "Continue in existing output folder"
    inputBinding:
      position: 102
      prefix: --cont
outputs:
  - id: outfolder
    type: Directory
    doc: "Output folder with the core genome"
    outputBinding:
      glob: "$(inputs.outfolder_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
