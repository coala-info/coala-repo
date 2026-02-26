cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfdist
label: vcfdist
doc: "Evaluate variant calls in a phased VCF file against a ground truth VCF and reference
  FASTA.\n\nTool homepage: https://github.com/TimD1/vcfdist"
inputs:
  - id: query_vcf
    type: File
    doc: phased VCF file containing variant calls to evaluate
    inputBinding:
      position: 1
  - id: truth_vcf
    type: File
    doc: phased VCF file containing ground truth variant calls
    inputBinding:
      position: 2
  - id: ref_fasta
    type: File
    doc: FASTA file containing draft reference sequence
    inputBinding:
      position: 3
  - id: advanced
    type:
      - 'null'
      - boolean
    doc: show advanced options, not recommended for most users
    inputBinding:
      position: 104
      prefix: --advanced
  - id: bed_file
    type:
      - 'null'
      - File
    doc: BED file containing regions to evaluate
    inputBinding:
      position: 104
      prefix: --bed
  - id: citation
    type:
      - 'null'
      - boolean
    doc: please cite vcfdist if used in your analyses. Thanks :)
    inputBinding:
      position: 104
      prefix: --citation
  - id: credit_threshold
    type:
      - 'null'
      - float
    doc: minimum partial credit to consider variant a true positive
    default: 0.7
    inputBinding:
      position: 104
      prefix: --credit-threshold
  - id: filter_regions
    type:
      - 'null'
      - type: array
        items: string
    doc: select just variants passing these FILTERs (OR operation)
    default: ALL
    inputBinding:
      position: 104
      prefix: --filter
  - id: gap_extend_penalty
    type:
      - 'null'
      - int
    doc: Smith-Waterman gap extension penalty
    default: 2
    inputBinding:
      position: 104
      prefix: --gap-extend-penalty
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: Smith-Waterman gap opening penalty
    default: 6
    inputBinding:
      position: 104
      prefix: --gap-open-penalty
  - id: include_distance
    type:
      - 'null'
      - boolean
    doc: flag to include alignment distance calculations, skipped by default
    inputBinding:
      position: 104
      prefix: --distance
  - id: largest_variant
    type:
      - 'null'
      - int
    doc: maximum variant size, larger variants ignored
    default: 5000
    inputBinding:
      position: 104
      prefix: --largest-variant
  - id: max_qual
    type:
      - 'null'
      - int
    doc: maximum variant quality, higher qualities kept but thresholded
    default: 60
    inputBinding:
      position: 104
      prefix: --max-qual
  - id: max_ram
    type:
      - 'null'
      - string
    doc: (approximate) maximum RAM to use for precision/recall alignment
    default: 64.000GB
    inputBinding:
      position: 104
      prefix: --max-ram
  - id: max_threads
    type:
      - 'null'
      - int
    doc: maximum threads to use for clustering and precision/recall alignment
    default: 64
    inputBinding:
      position: 104
      prefix: --max-threads
  - id: min_qual
    type:
      - 'null'
      - int
    doc: minimum variant quality, lower qualities ignored
    default: 0
    inputBinding:
      position: 104
      prefix: --min-qual
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Smith-Waterman mismatch (substitution) penalty
    default: 5
    inputBinding:
      position: 104
      prefix: --mismatch-penalty
  - id: no_output_files
    type:
      - 'null'
      - boolean
    doc: skip writing output files, only print summary to console
    inputBinding:
      position: 104
      prefix: --no-output-files
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix for output files (directory needs a trailing slash)
    default: ./
    inputBinding:
      position: 104
      prefix: --prefix
  - id: realign_only
    type:
      - 'null'
      - boolean
    doc: standardize truth and query variant representations, then exit
    inputBinding:
      position: 104
      prefix: --realign-only
  - id: realign_query
    type:
      - 'null'
      - boolean
    doc: realign query variants using Smith-Waterman parameters
    inputBinding:
      position: 104
      prefix: --realign-query
  - id: realign_truth
    type:
      - 'null'
      - boolean
    doc: realign truth variants using Smith-Waterman parameters
    inputBinding:
      position: 104
      prefix: --realign-truth
  - id: sv_threshold
    type:
      - 'null'
      - int
    doc: variants of this size or larger are considered SVs, not INDELs
    default: 50
    inputBinding:
      position: 104
      prefix: --sv-threshold
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'printing verbosity (0: succinct, 1: default, 2:verbose)'
    default: 1
    inputBinding:
      position: 104
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfdist:2.6.4--h436c8a6_0
stdout: vcfdist.out
