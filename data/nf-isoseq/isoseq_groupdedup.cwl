cwlVersion: v1.2
class: CommandLineTool
baseCommand: isoseq groupdedup
label: isoseq_groupdedup
doc: "Deduplicate PCR artifacts grouped by cell barcode (barcode-sorted FLTNC to DEDUP)\n\
  \nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs:
  - id: input_fltnc
    type: string
    doc: Input FLTNC BAM, ConsensusReadSet XML, or FOFN, sorted by cell barcode 
      (CB or XC tags)
    inputBinding:
      position: 1
  - id: output_fltnc
    type: string
    doc: Output BAM or ConsensusReadSet XML
    inputBinding:
      position: 2
  - id: barcode_tag
    type:
      - 'null'
      - string
    doc: Specify BAM cell/group tag by which to group. If empty, checks CB and 
      XC.
    inputBinding:
      position: 103
      prefix: --barcode-tag
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of BAM records to load per batch.
    inputBinding:
      position: 103
      prefix: --batch-size
  - id: keep_fail_barcodes
    type:
      - 'null'
      - boolean
    doc: Do not skip reads with failed barcodes.
    inputBinding:
      position: 103
      prefix: --keep-fail-barcodes
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
    inputBinding:
      position: 103
      prefix: --log-level
  - id: max_insert_gaps
    type:
      - 'null'
      - int
    doc: Maximum number of insert gaps per 20 bp window.
    inputBinding:
      position: 103
      prefix: --max-insert-gaps
  - id: max_insert_pad
    type:
      - 'null'
      - int
    doc: Maximum number of missing flanking bases on either insert side.
    inputBinding:
      position: 103
      prefix: --max-insert-pad
  - id: max_length_difference
    type:
      - 'null'
      - int
    doc: Maximum insert lengths difference.
    inputBinding:
      position: 103
      prefix: --max-length-difference
  - id: max_tag_mismatches
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches between tags.
    inputBinding:
      position: 103
      prefix: --max-tag-mismatches
  - id: max_tag_shift
    type:
      - 'null'
      - int
    doc: Tags may be shifted by at maximum of N bases.
    inputBinding:
      position: 103
      prefix: --max-tag-shift
  - id: min_concordance_perc
    type:
      - 'null'
      - int
    doc: Minimum insert alignment concordance in %.
    inputBinding:
      position: 103
      prefix: --min-concordance-perc
  - id: no_poa
    type:
      - 'null'
      - boolean
    doc: Select highest-pass read in set instead of generating consensus 
      sequence with POA (partial order alignment).
    inputBinding:
      position: 103
      prefix: --no-poa
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 103
      prefix: --num-threads
  - id: poa_cov
    type:
      - 'null'
      - int
    doc: Maximum number of input reads used for POA consensus.
    inputBinding:
      position: 103
      prefix: --poa-cov
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Use verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
stdout: isoseq_groupdedup.out
