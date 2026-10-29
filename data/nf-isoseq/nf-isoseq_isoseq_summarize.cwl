cwlVersion: v1.2
class: CommandLineTool
baseCommand: [isoseq, summarize]
label: nf-isoseq_isoseq_summarize
doc: "Create barcode overview from transcripts (TRANSCRIPTS to CSV)

Tool homepage: https://github.com/PacificBiosciences/pbbioconda"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: transcripts_bam
    type: File
    doc: "Input transcripts BAM or TranscriptSet XML"
    secondaryFiles:
      - pattern: .pbi
        required: false
    inputBinding:
      position: 1
  - id: summary_output
    type: string
    doc: "Output summary CSV"
    inputBinding:
      position: 2
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
outputs:
  - id: summary_csv
    type: File
    doc: "Barcode summary CSV"
    outputBinding:
      glob: $(inputs.summary_output)
  - id: log_output
    type: ['null', File]
    doc: "Log file (when log_file is set)"
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
