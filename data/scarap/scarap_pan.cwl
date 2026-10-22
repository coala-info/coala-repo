cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scarap
  - pan
label: scarap_pan
doc: "Infer a pangenome from a set of faa files.\n\nTool homepage: https://github.com/SWittouck/SCARAP"
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
  - id: species
    type:
      - 'null'
      - File
    doc: "Input file with species of genomes; if given, a hierarchical pangenome strategy will be used for final database selection"
    inputBinding:
      position: 110
      prefix: --species
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
    doc: "Output folder with the pangenome"
    outputBinding:
      glob: "$(inputs.outfolder_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
