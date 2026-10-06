cwlVersion: v1.2
class: CommandLineTool
baseCommand: actc
label: actc
doc: "Align clr to ccs reads.\n\nTool homepage: https://github.com/PacificBiosciences/actc"
inputs:
  - id: subreads_bam
    type: File
    doc: Subreads BAM. Needs its PacBio index (.pbi) beside it.
    secondaryFiles:
      - .pbi
    inputBinding:
      position: 1
  - id: ccs_bam
    type: File
    doc: CCS BAM. Needs its PacBio index (.pbi) beside it.
    secondaryFiles:
      - .pbi
    inputBinding:
      position: 2
  - id: out_bam
    type: string
    doc: Aligned subreads to CCS BAM.
    inputBinding:
      position: 3
  - id: chunk
    type:
      - 'null'
      - string
    doc: 'Operate on a single chunk. Format i/N, where i in [1,N]. Examples: 3/24
      or 9/9'
    inputBinding:
      position: 103
      prefix: --chunk
  - id: log_file
    type:
      - 'null'
      - string
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
  - id: min_ccs_length
    type:
      - 'null'
      - int
    doc: Minimum CCS read length after --trim-flanks-bp
    inputBinding:
      position: 103
      prefix: --min-ccs-length
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 103
      prefix: --num-threads
  - id: trim_flanks_bp
    type:
      - 'null'
      - int
    doc: Trim N bp from each flank of the CCS read alignment
    inputBinding:
      position: 103
      prefix: --trim-flanks-bp
outputs:
  - id: output_bam
    type: File
    doc: Aligned subreads to CCS BAM.
    outputBinding:
      glob: '$(inputs.out_bam)'
  - id: ccs_fasta
    type: File
    doc: CCS reads in FASTA format, written beside the output BAM.
    outputBinding:
      glob: '*.fasta'
  - id: log_output
    type:
      - 'null'
      - File
    doc: Log file, when --log-file is set.
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/actc:0.6.1--h9ee0642_0
