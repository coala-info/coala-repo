cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccs-kinetics-bystrandify
label: pbtk_ccs-kinetics-bystrandify
doc: "ccs-kinetics-bystrandify converts a BAM containing CCS-Kinetics tags to a pseudo-bystrand
  CCS BAM with pw/ip tags that can be used as a substitute for subreads in applications
  expecting such kinetic information.\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs:
  - id: input_file
    type: File
    doc: CCS BAM or ConsensusReadSet XML
    inputBinding:
      position: 1
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
    inputBinding:
      position: 102
      prefix: --log-level
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Specifies the minimum number of passes per strand (fn/rn) for creating a
      strand-specific read.
    inputBinding:
      position: 102
      prefix: --min-coverage
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 102
      prefix: --num-threads
outputs:
  - id: output_file
    type: File
    doc: Output CCS BAM or ConsensusReadSet XML
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbtk:3.5.0--h9ee0642_0
