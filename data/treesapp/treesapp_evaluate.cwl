cwlVersion: v1.2
class: CommandLineTool
baseCommand: [treesapp, evaluate]
label: treesapp_evaluate
doc: "Evaluate classification performance using clade-exclusion analysis.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
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
  - id: delete
    type:
      - 'null'
      - boolean
    doc: "Delete all intermediate files to save disk space."
    inputBinding:
      position: 101
      prefix: --delete
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
  - id: accession2taxid
    type:
      - 'null'
      - File
    doc: "Path to an NCBI accession2taxid file for more rapid accession-to-lineage mapping."
    inputBinding:
      position: 101
      prefix: --accession2taxid
  - id: accession2lin
    type:
      - 'null'
      - File
    doc: "Path to a file that maps sequence accessions to taxonomic lineages, possibly made by `treesapp create`."
    inputBinding:
      position: 101
      prefix: --accession2lin
  - id: num_procs
    type:
      - 'null'
      - int
    doc: "The number of CPU threads or parallel processes to use in various pipeline steps [ DEFAULT = 2 ]"
    inputBinding:
      position: 101
      prefix: --num_procs
  - id: min_like_weight_ratio
    type:
      - 'null'
      - float
    doc: "The minimum likelihood weight ratio required for an EPA placement. [ DEFAULT = 0.1 ]"
    inputBinding:
      position: 101
      prefix: --min_like_weight_ratio
  - id: max_pendant_length
    type:
      - 'null'
      - float
    doc: "The maximum pendant length distance threshold, beyond which EPA placements are unclassified. [ DEFAULT = Inf ]"
    inputBinding:
      position: 101
      prefix: --max_pendant_length
  - id: max_evol_distance
    type:
      - 'null'
      - float
    doc: "The maximum total evolutionary distance between a query and reference(s), beyond which EPA placements are unclassified. [ DEFAULT = Inf ]"
    inputBinding:
      position: 101
      prefix: --max_evol_distance
  - id: placement_summary
    type:
      - 'null'
      - string
    doc: "Algorithm for consolidating multiple phylogenetic placements: aelw, max_lwr or lca."
    inputBinding:
      position: 101
      prefix: --placement_summary
  - id: taxonomic_ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: "Taxonomic ranks (space-separated) to test: domain, phylum, class, order, family, genus, species. [ DEFAULT = class species ]"
    inputBinding:
      position: 101
      prefix: --taxonomic_ranks
  - id: fresh
    type:
      - 'null'
      - boolean
    doc: "Recalculate a fresh phylogenetic tree with the target clades removed instead of removing the leaves from the reference tree."
    inputBinding:
      position: 101
      prefix: --fresh
  - id: tool
    type:
      - 'null'
      - string
    doc: "Classify using one of the tools: treesapp, graftm or diamond. [DEFAULT = treesapp]"
    inputBinding:
      position: 101
      prefix: --tool
  - id: length
    type:
      - 'null'
      - int
    doc: "Arbitrarily slice the input sequences to this length."
    inputBinding:
      position: 101
      prefix: --length
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
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Clade-exclusion evaluation output directory"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
