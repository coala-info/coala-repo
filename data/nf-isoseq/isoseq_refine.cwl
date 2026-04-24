cwlVersion: v1.2
class: CommandLineTool
baseCommand: isoseq refine
label: isoseq_refine
doc: "Remove polyA and concatemers from FL reads and generate FLNC transcripts (FL
  to FLNC)\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs:
  - id: demux_input
    type: File
    doc: Input cDNA demuxed BAM or ConsensusReadSet XML
    inputBinding:
      position: 1
  - id: primer_input
    type: File
    doc: Input primer FASTA or BarcodeSet XML
    inputBinding:
      position: 2
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL).'
    inputBinding:
      position: 103
      prefix: --log-level
  - id: min_polya_length
    type:
      - 'null'
      - int
    doc: Minimum poly(A) tail length.
    inputBinding:
      position: 103
      prefix: --min-polya-length
  - id: min_rq
    type:
      - 'null'
      - float
    doc: Minimum CCS RQ. Default is -1, deactivated
    inputBinding:
      position: 103
      prefix: --min-rq
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 103
      prefix: --num-threads
  - id: require_polya
    type:
      - 'null'
      - boolean
    doc: Require FL reads to have a poly(A) tail and remove it.
    inputBinding:
      position: 103
      prefix: --require-polya
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Use verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: flnc_output
    type: File
    doc: Output flnc BAM or ConsensusReadSet XML
    outputBinding:
      glob: '*.out'
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log to a file, instead of stderr.
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
