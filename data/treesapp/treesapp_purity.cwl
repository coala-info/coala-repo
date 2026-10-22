cwlVersion: v1.2
class: CommandLineTool
baseCommand: [treesapp, purity]
label: treesapp_purity
doc: "Validate the functional purity of a reference package.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: fastx_input
    type:
      type: array
      items: File
    doc: "Input file(s) containing DNA or protein sequences in FASTA or FASTQ format"
    inputBinding:
      position: 101
      prefix: --fastx_input
  - id: refpkg_path
    type:
      type: array
      items: File
    doc: "Path to the reference package pickle (.pkl) file(s)."
    inputBinding:
      position: 101
      prefix: --refpkg_path
  - id: output
    type:
      - 'null'
      - string
    doc: "Path to an output directory [DEFAULT = ./output/]"
    default: output
    inputBinding:
      position: 101
      prefix: --output
  - id: trim_align
    type:
      - 'null'
      - boolean
    doc: "Flag to turn on position masking of the multiple sequence alignment"
    inputBinding:
      position: 101
      prefix: --trim_align
  - id: min_seq_length
    type:
      - 'null'
      - int
    doc: "Minimal sequence length after alignment trimming [DEFAULT = 0]"
    inputBinding:
      position: 101
      prefix: --min_seq_length
  - id: molecule
    type:
      - 'null'
      - string
    doc: "Type of input sequences: prot, dna or rrna. TreeSAPP guesses by default."
    inputBinding:
      position: 101
      prefix: --molecule
  - id: extra_info
    type:
      - 'null'
      - File
    doc: "File mapping header prefixes to description information."
    inputBinding:
      position: 101
      prefix: --extra_info
  - id: stage
    type:
      - 'null'
      - string
    doc: "The stage(s) to execute: continue, lineages, classify or calculate. [DEFAULT = continue]"
    inputBinding:
      position: 101
      prefix: --stage
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Overwrites previously written output files and directories"
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Prints a more verbose runtime log"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: delete
    type:
      - 'null'
      - boolean
    doc: "Delete all intermediate files to save disk space."
    inputBinding:
      position: 101
      prefix: --delete
  - id: num_procs
    type:
      - 'null'
      - int
    doc: "The number of CPU threads or parallel processes to use in various pipeline steps [ DEFAULT = 2 ]"
    inputBinding:
      position: 101
      prefix: --num_procs
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Purity validation output directory"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
