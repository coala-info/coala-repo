cwlVersion: v1.2
class: CommandLineTool
baseCommand: isoseq cluster
label: isoseq_cluster
doc: "Cluster FLNC reads and generate transcripts (FLNC to TRANSCRIPTS)\n\nTool homepage:
  https://github.com/PacificBiosciences/pbbioconda"
inputs:
  - id: flnc_input
    type: string
    doc: Input flnc BAM or ConsensusReadSet XML
    inputBinding:
      position: 1
  - id: transcripts_input
    type: string
    doc: Input transcripts BAM or TranscriptSet XML
    inputBinding:
      position: 2
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
  - id: max_poa_ccs_reads
    type:
      - 'null'
      - int
    doc: Maximum number of CCS reads used for POA consensus.
    default: 100
    inputBinding:
      position: 103
      prefix: --poa-cov
  - id: min_subreads_split
    type:
      - 'null'
      - int
    doc: Subread threshold for HQ/LQ split.
    default: 7
    inputBinding:
      position: 103
      prefix: --min-subreads-split
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    default: 0
    inputBinding:
      position: 103
      prefix: --num-threads
  - id: output_singletons
    type:
      - 'null'
      - boolean
    doc: Output FLNCs that could not be clustered.
    inputBinding:
      position: 103
      prefix: --singletons
  - id: split_bam_max_files
    type:
      - 'null'
      - int
    doc: Split BAM output files into at maximum N files; 0 means no splitting
    default: 0
    inputBinding:
      position: 103
      prefix: --split-bam
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
stdout: isoseq_cluster.out
