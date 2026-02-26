cwlVersion: v1.2
class: CommandLineTool
baseCommand: isoseq cluster2
label: isoseq3_cluster2
doc: "Cluster FLNC reads and generate transcripts, much faster than \"cluster\" (FLNC
  to TRANSCRIPTS)\n\nTool homepage: https://github.com/PacificBiosciences/IsoSeq3"
inputs:
  - id: flnc_input
    type: string
    doc: Input flnc BAM, ConsensusReadSet XML, or FOFN
    inputBinding:
      position: 1
  - id: transcripts_bam
    type: File
    doc: Output transcripts BAM
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
  - id: sort_threads
    type:
      - 'null'
      - int
    doc: Number of sorting threads per BAM file. Equivalent to open file handles
      per BAM. Defaults to -j.
    default: 0
    inputBinding:
      position: 103
      prefix: --sort-threads
outputs:
  - id: write_bam
    type:
      - 'null'
      - File
    doc: Write annotated BAM file.
    outputBinding:
      glob: $(inputs.write_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
