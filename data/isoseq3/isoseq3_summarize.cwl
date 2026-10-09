cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq
  - summarize
label: isoseq3_summarize
doc: "Create barcode overview from transcripts (TRANSCRIPTS to CSV)\n\nTool homepage: https://github.com/PacificBiosciences/IsoSeq3"
inputs:
  - id: transcripts_input
    type: File
    doc: "Input transcripts BAM."
    inputBinding:
      position: 1
  - id: summary_output
    type: string
    default: summary.csv
    doc: "Output summary CSV."
    inputBinding:
      position: 2
  - id: log_level
    type: ['null', string]
    doc: "Set log level. Valid choices: (TRACE, DEBUG, INFO, WARN, FATAL)."
    inputBinding:
      position: 103
      prefix: --log-level
  - id: log_file_path
    type: ['null', string]
    doc: "Log to a file, instead of stderr."
    inputBinding:
      position: 103
      prefix: --log-file
outputs:
  - id: summary_csv
    type: File
    doc: "Summary CSV."
    outputBinding:
      glob: $(inputs.summary_output)
  - id: log_file
    type: ['null', File]
    doc: "Log file, when log_file_path is set."
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: TMPDIR
        envValue: "/tmp/"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
