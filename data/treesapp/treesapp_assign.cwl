cwlVersion: v1.2
class: CommandLineTool
baseCommand: treesapp_assign
label: treesapp_assign
doc: "Classify sequences through evolutionary placement.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: An input file containing DNA or protein sequences in either FASTA or 
      FASTQ format
    inputBinding:
      position: 1
  - id: composition
    type:
      - 'null'
      - string
    doc: Sample composition being either a single organism or a metagenome.
    inputBinding:
      position: 102
      prefix: --composition
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Delete all intermediate files to save disk space.
    inputBinding:
      position: 102
      prefix: --delete
  - id: hmm_coverage
    type:
      - 'null'
      - float
    doc: Minimum percentage of a profile HMM that a query alignment must cover 
      for it to be considered.
    default: 80
    inputBinding:
      position: 102
      prefix: --hmm_coverage
  - id: max_evo
    type:
      - 'null'
      - float
    doc: The maximum total evolutionary distance between a query and 
      reference(s), beyond which EPA placements are unclassified.
    default: Inf
    inputBinding:
      position: 102
      prefix: --max_evol_distance
  - id: max_pd
    type:
      - 'null'
      - float
    doc: The maximum pendant length distance threshold, beyond which EPA 
      placements are unclassified.
    default: Inf
    inputBinding:
      position: 102
      prefix: --max_pendant_length
  - id: metric
    type:
      - 'null'
      - string
    doc: Selects which normalization metric to use, FPKM or TPM.
    default: tpm
    inputBinding:
      position: 102
      prefix: --metric
  - id: min_lwr
    type:
      - 'null'
      - float
    doc: The minimum likelihood weight ratio required for an EPA placement.
    default: 0.1
    inputBinding:
      position: 102
      prefix: --min_like_weight_ratio
  - id: min_seq_length
    type:
      - 'null'
      - int
    doc: minimal sequence length after alignment trimming
    default: 0
    inputBinding:
      position: 102
      prefix: --min_seq_length
  - id: molecule
    type:
      - 'null'
      - string
    doc: Type of input sequences (prot = protein; dna = nucleotide; rrna = 
      rRNA). TreeSAPP will guess by default but this may be required if 
      ambiguous.
    inputBinding:
      position: 102
      prefix: --molecule
  - id: num_threads
    type:
      - 'null'
      - int
    doc: The number of CPU threads or parallel processes to use in various 
      pipeline steps
    default: 2
    inputBinding:
      position: 102
      prefix: --num_procs
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrites previously written output files and directories
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: pairing
    type:
      - 'null'
      - string
    doc: Indicating whether the reads are paired-end (pe) or single-end (se).
    default: pe
    inputBinding:
      position: 102
      prefix: --pairing
  - id: placement_summary
    type:
      - 'null'
      - string
    doc: Controls the algorithm for consolidating multiple phylogenetic 
      placements. Max LWR will take use the phylogenetic placement with greatest
      LWR. aELW uses the taxon with greatest accumulated LWR across placements.
    inputBinding:
      position: 102
      prefix: --placement_summary
  - id: query_coverage
    type:
      - 'null'
      - float
    doc: Minimum percentage of a query sequence that an alignment must cover to 
      be retained.
    default: 80
    inputBinding:
      position: 102
      prefix: --query_coverage
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ file containing to be aligned to predicted genes using BWA MEM
    inputBinding:
      position: 102
      prefix: --reads
  - id: refpkg_dir
    type:
      - 'null'
      - Directory
    doc: Path to the directory containing reference package pickle (.pkl) files.
    default: treesapp/data/
    inputBinding:
      position: 102
      prefix: --refpkg_dir
  - id: reftree
    type:
      - 'null'
      - File
    doc: '[IN PROGRESS] Reference package that all queries should be immediately and
      directly classified as (i.e. homology search step is skipped).'
    inputBinding:
      position: 102
      prefix: --reftree
  - id: rel_abund
    type:
      - 'null'
      - boolean
    doc: Flag indicating relative abundance values should be calculated for the 
      sequences detected
    inputBinding:
      position: 102
      prefix: --rel_abund
  - id: reverse
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ file containing to reverse mate-pair reads to be aligned using 
      BWA MEM
    inputBinding:
      position: 102
      prefix: --reverse
  - id: silent
    type:
      - 'null'
      - boolean
    doc: treesapp assign will not log anything to the console if used.
    inputBinding:
      position: 102
      prefix: --silent
  - id: stage
    type:
      - 'null'
      - string
    doc: The stage(s) for TreeSAPP to execute
    default: continue
    inputBinding:
      position: 102
      prefix: --stage
  - id: stringency
    type:
      - 'null'
      - string
    doc: HMM-threshold mode affects the number of query sequences that advance
    default: relaxed
    inputBinding:
      position: 102
      prefix: --stringency
  - id: svm
    type:
      - 'null'
      - boolean
    doc: "Uses the support vector machine (SVM) classification filter. WARNING: Unless
      you *really* know your refpkg, you don't want this."
    inputBinding:
      position: 102
      prefix: --svm
  - id: svm_kernel
    type:
      - 'null'
      - string
    doc: Specifies the kernel type to be used in the SVM algorithm. It must be 
      either 'lin' 'poly' or 'rbf'.
    default: lin
    inputBinding:
      position: 102
      prefix: --svm_kernel
  - id: targets
    type:
      - 'null'
      - string
    doc: A comma-separated list specifying which reference packages to use. They
      are to be referenced by their 'prefix' attribute. Use `treesapp info -v` 
      to get the available list
    default: ALL
    inputBinding:
      position: 102
      prefix: --targets
  - id: trim_align
    type:
      - 'null'
      - boolean
    doc: Flag to turn on position masking of the multiple sequence alignment
    default: false
    inputBinding:
      position: 102
      prefix: --trim_align
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Prints a more verbose runtime log
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Path to an output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
