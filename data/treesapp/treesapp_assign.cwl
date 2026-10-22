cwlVersion: v1.2
class: CommandLineTool
baseCommand: [treesapp, assign]
label: treesapp_assign
doc: "Classify sequences through evolutionary placement.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: fastx_input
    type:
      type: array
      items: File
    doc: "Input file(s) containing DNA or protein sequences in FASTA or FASTQ format"
    inputBinding:
      position: 101
      prefix: --fastx_input
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
  - id: refpkg_dir
    type:
      - 'null'
      - Directory
    doc: "Path to the directory containing reference package pickle (.pkl) files. [ DEFAULT = treesapp/data/ ]"
    inputBinding:
      position: 101
      prefix: --refpkg_dir
  - id: targets
    type:
      - 'null'
      - string
    doc: "A comma-separated list specifying which reference packages to use, by their 'prefix' attribute. [ DEFAULT = ALL ]"
    inputBinding:
      position: 101
      prefix: --targets
  - id: metric
    type:
      - 'null'
      - string
    doc: "Normalization metric to use: fpkm or tpm. [ DEFAULT = tpm ]"
    inputBinding:
      position: 101
      prefix: --metric
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: "FASTQ file(s) to be aligned to predicted genes using BWA MEM"
    inputBinding:
      position: 101
      prefix: --reads
  - id: reverse
    type:
      - 'null'
      - type: array
        items: File
    doc: "FASTQ file(s) with reverse mate-pair reads to be aligned using BWA MEM"
    inputBinding:
      position: 101
      prefix: --reverse
  - id: pairing
    type:
      - 'null'
      - string
    doc: "Whether the reads are paired-end (pe) or single-end (se). [ DEFAULT = pe ]"
    inputBinding:
      position: 101
      prefix: --pairing
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
  - id: stringency
    type:
      - 'null'
      - string
    doc: "HMM-threshold mode: relaxed or strict. [DEFAULT = relaxed]"
    inputBinding:
      position: 101
      prefix: --stringency
  - id: hmm_coverage
    type:
      - 'null'
      - float
    doc: "Minimum percentage of a profile HMM that a query alignment must cover for it to be considered. [ DEFAULT = 80 ]"
    inputBinding:
      position: 101
      prefix: --hmm_coverage
  - id: query_coverage
    type:
      - 'null'
      - float
    doc: "Minimum percentage of a query sequence that an alignment must cover to be retained. [ DEFAULT = 80 ]"
    inputBinding:
      position: 101
      prefix: --query_coverage
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
  - id: num_procs
    type:
      - 'null'
      - int
    doc: "The number of CPU threads or parallel processes to use in various pipeline steps [ DEFAULT = 2 ]"
    inputBinding:
      position: 101
      prefix: --num_procs
  - id: svm_kernel
    type:
      - 'null'
      - string
    doc: "Kernel type to be used in the SVM algorithm: lin, poly or rbf. [ DEFAULT = lin ]"
    inputBinding:
      position: 101
      prefix: --svm_kernel
  - id: svm
    type:
      - 'null'
      - boolean
    doc: "Uses the support vector machine (SVM) classification filter."
    inputBinding:
      position: 101
      prefix: --svm
  - id: composition
    type:
      - 'null'
      - string
    doc: "Sample composition: meta or single."
    inputBinding:
      position: 101
      prefix: --composition
  - id: stage
    type:
      - 'null'
      - string
    doc: "The stage(s) to execute: continue, orf-call, search, align, place or classify. [DEFAULT = continue]"
    inputBinding:
      position: 101
      prefix: --stage
  - id: rel_abund
    type:
      - 'null'
      - boolean
    doc: "Calculate relative abundance values for the sequences detected"
    inputBinding:
      position: 101
      prefix: --rel_abund
  - id: reftree
    type:
      - 'null'
      - string
    doc: "Reference package that all queries should be classified as (homology search is skipped). [IN PROGRESS]"
    inputBinding:
      position: 101
      prefix: --reftree
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "Do not log anything to the console."
    inputBinding:
      position: 101
      prefix: --silent
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "TreeSAPP assign output directory"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
