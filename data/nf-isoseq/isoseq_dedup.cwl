cwlVersion: v1.2
class: CommandLineTool
baseCommand: [isoseq, dedup]
label: isoseq_dedup
doc: "Deduplicate PCR artifacts (FLTNC to DEDUP)

Tool homepage: https://github.com/PacificBiosciences/pbbioconda"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: fltnc_bam
    type: File
    doc: "Input FLTNC BAM or ConsensusReadSet XML"
    secondaryFiles:
      - pattern: .pbi
        required: false
    inputBinding:
      position: 1
  - id: dedup_output
    type: string
    doc: "Output dedup BAM or ConsensusReadSet XML"
    inputBinding:
      position: 2
  - id: poa_cov
    type: ['null', int]
    doc: "Maximum number of input reads used for POA consensus. [10]"
    inputBinding:
      position: 100
      prefix: --poa-cov
  - id: max_tag_mismatches
    type: ['null', int]
    doc: "Maximum number of mismatches between tags. [1]"
    inputBinding:
      position: 100
      prefix: --max-tag-mismatches
  - id: max_tag_shift
    type: ['null', int]
    doc: "Tags may be shifted by at maximum of N bases. [1]"
    inputBinding:
      position: 100
      prefix: --max-tag-shift
  - id: max_insert_length_diff
    type: ['null', int]
    doc: "Maximum insert lengths difference. [50]"
    inputBinding:
      position: 100
      prefix: --max-insert-length-diff
  - id: max_insert_pad
    type: ['null', int]
    doc: "Maximum number of missing flanking bases on either insert side. [5]"
    inputBinding:
      position: 100
      prefix: --max-insert-pad
  - id: min_concordance_perc
    type: ['null', int]
    doc: "Minimum insert alignment concordance in %. [97]"
    inputBinding:
      position: 100
      prefix: --min-concordance-perc
  - id: max_insert_gaps
    type: ['null', int]
    doc: "Maximum number of insert gaps per 20 bp window. [5]"
    inputBinding:
      position: 100
      prefix: --max-insert-gaps
  - id: keep_non_real_cells
    type: ['null', boolean]
    doc: "Do not skip reads with non-real cells."
    inputBinding:
      position: 100
      prefix: --keep-non-real-cells
  - id: keep_fail_barcodes
    type: ['null', boolean]
    doc: "Do not skip reads with failed barcodes."
    inputBinding:
      position: 100
      prefix: --keep-fail-barcodes
  - id: log_level
    type: ['null', string]
    doc: "Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL). [WARN]"
    inputBinding:
      position: 100
      prefix: --log-level
  - id: log_file
    type: ['null', string]
    doc: "Log to a file, instead of stderr."
    inputBinding:
      position: 100
      prefix: --log-file
  - id: num_threads
    type: ['null', int]
    doc: "Number of threads to use, 0 means autodetection. [0]"
    inputBinding:
      position: 100
      prefix: --num-threads
  - id: verbose
    type: ['null', boolean]
    doc: "Use verbose output."
    inputBinding:
      position: 100
      prefix: --verbose
outputs:
  - id: dedup_bam
    type: File
    doc: "Deduplicated BAM"
    secondaryFiles:
      - pattern: .pbi
        required: false
    outputBinding:
      glob: $(inputs.dedup_output)
  - id: dedup_fasta
    type: ['null', File]
    doc: "Deduplicated reads FASTA"
    outputBinding:
      glob: $(inputs.dedup_output.replace(/\.(bam|xml)$/, '')).fasta
  - id: log_output
    type: ['null', File]
    doc: "Log file (when log_file is set)"
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
