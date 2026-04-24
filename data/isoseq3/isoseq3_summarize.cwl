cwlVersion: v1.2
class: CommandLineTool
baseCommand: isoseq summarize
label: isoseq3_summarize
doc: "Create barcode overview from transcripts (TRANSCRIPTS to CSV)\n\nTool homepage:
  https://github.com/PacificBiosciences/IsoSeq3"
inputs:
  - id: transcripts_input
    type: string
    doc: Input transcripts BAM or TranscriptSet XML
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
outputs:
  - id: summary_output
    type: File
    doc: Output summary CSV
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
