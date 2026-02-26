cwlVersion: v1.2
class: CommandLineTool
baseCommand: isoseq collapse
label: isoseq_collapse
doc: "Collapse transcripts based on genomic mapping\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs:
  - id: alignments
    type: File
    doc: Alignments mapping Transcripts to reference genome
    inputBinding:
      position: 1
  - id: flnc
    type:
      - 'null'
      - File
    doc: FLNC BAM, optional input
    inputBinding:
      position: 2
  - id: do_not_collapse_extra_5exons
    type:
      - 'null'
      - boolean
    doc: Do not collapse 5' shorter transcripts which miss one or multiple 5' 
      exons to a longer transcript.
    inputBinding:
      position: 103
      prefix: --do-not-collapse-extra-5exons
  - id: keep_non_real_cells
    type:
      - 'null'
      - boolean
    doc: Do not skip reads with non-real cells.
    inputBinding:
      position: 103
      prefix: --keep-non-real-cells
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log to a file, instead of stderr.
    inputBinding:
      position: 103
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL).'
    default: WARN
    inputBinding:
      position: 103
      prefix: --log-level
  - id: max_3p_diff
    type:
      - 'null'
      - int
    doc: Maximum allowed 3' difference if on same exon.
    default: 100
    inputBinding:
      position: 103
      prefix: --max-3p-diff
  - id: max_5p_diff
    type:
      - 'null'
      - int
    doc: Maximum allowed 5' difference if on same exon.
    default: 50
    inputBinding:
      position: 103
      prefix: --max-5p-diff
  - id: max_batch_mem
    type:
      - 'null'
      - float
    doc: Maximum memory for batch loading, in megabytes (MB). Batches can be 
      slightly larger than this value. Value <= 0 loads all data in memory at 
      once.
    default: 4096.0
    inputBinding:
      position: 103
      prefix: --max-batch-mem
  - id: max_fuzzy_junction
    type:
      - 'null'
      - int
    doc: Ignore mismatches or indels shorter than or equal to N.
    default: 5
    inputBinding:
      position: 103
      prefix: --max-fuzzy-junction
  - id: min_aln_coverage
    type:
      - 'null'
      - float
    doc: Ignore alignments with less than minimum query read coverage.
    default: 0.99
    inputBinding:
      position: 103
      prefix: --min-aln-coverage
  - id: min_aln_identity
    type:
      - 'null'
      - float
    doc: Ignore alignments with less than minimum alignment identity.
    default: 0.95
    inputBinding:
      position: 103
      prefix: --min-aln-identity
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    default: 0
    inputBinding:
      position: 103
      prefix: --num-threads
  - id: split_group_size
    type:
      - 'null'
      - int
    doc: Groups larger than this will be linearly split for parallel processing.
    default: 100
    inputBinding:
      position: 103
      prefix: --split-group-size
outputs:
  - id: output_gff
    type: File
    doc: Collapsed transcripts GFF
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
