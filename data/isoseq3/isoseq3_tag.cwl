cwlVersion: v1.2
class: CommandLineTool
baseCommand: isoseq tag
label: isoseq3_tag
doc: "Remove cell barcodes and UMIs from FL reads and generate tagged FL transcripts
  (FL to FLT)\n\nTool homepage: https://github.com/PacificBiosciences/IsoSeq3"
inputs:
  - id: demux_bam
    type: File
    doc: Input cDNA demuxed BAM or ConsensusReadSet XML
    inputBinding:
      position: 1
  - id: design
    type:
      - 'null'
      - string
    doc: Barcoding design. Specifies which bases to use as cell/molecular 
      barcodes.
    default: T-8U-10B
    inputBinding:
      position: 102
      prefix: --design
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log to a file, instead of stderr.
    inputBinding:
      position: 102
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL).'
    default: WARN
    inputBinding:
      position: 102
      prefix: --log-level
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length after trimming.
    default: 50
    inputBinding:
      position: 102
      prefix: --min-read-length
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    default: 0
    inputBinding:
      position: 102
      prefix: --num-threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Use verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: flt_bam
    type: File
    doc: Output FLT BAM or ConsensusReadSet XML
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
