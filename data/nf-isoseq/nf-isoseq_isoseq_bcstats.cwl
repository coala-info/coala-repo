cwlVersion: v1.2
class: CommandLineTool
baseCommand: [isoseq, bcstats]
label: nf-isoseq_isoseq_bcstats
doc: "Generates stats for group barcodes and (optionally) molecular barcodes

Tool homepage: https://github.com/PacificBiosciences/pbbioconda"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_bam
    type: File
    doc: "Input BAM, ConsensusReadSet XML, or FOFN"
    secondaryFiles:
      - pattern: .pbi
        required: false
    inputBinding:
      position: 1
  - id: molecular
    type: ['null', boolean]
    doc: "Emit stats for molecular barcodes (UMIs) as well as cell barcodes."
    inputBinding:
      position: 100
      prefix: --molecular
  - id: output
    type: string
    doc: "Output tsv of stats for input BAM files."
    inputBinding:
      position: 100
      prefix: --output
  - id: json
    type: ['null', string]
    doc: "Path to emit output JSON report."
    inputBinding:
      position: 100
      prefix: --json
  - id: deduplicated
    type: ['null', boolean]
    doc: "To mark as de-duplicated."
    inputBinding:
      position: 100
      prefix: --deduplicated
  - id: batch_size
    type: ['null', int]
    doc: "Batch size for processing. [65536]"
    inputBinding:
      position: 100
      prefix: --batch-size
  - id: percentile
    type: ['null', int]
    doc: "Percentile to use when calculating real vs non-real cells (method percentile). [99]"
    inputBinding:
      position: 100
      prefix: --percentile
  - id: target
    type: ['null', string]
    doc: "Determine real vs non-real cells by readcount or umicount. [umicount]"
    inputBinding:
      position: 100
      prefix: --target
  - id: method
    type: ['null', string]
    doc: "Determine real vs non-real cells using knee or percentile. [knee]"
    inputBinding:
      position: 100
      prefix: --method
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
  - id: stats_tsv
    type: File
    doc: "Barcode statistics table"
    outputBinding:
      glob: $(inputs.output)
  - id: stats_json
    type: ['null', File]
    doc: "JSON report"
    outputBinding:
      glob: $(inputs.json)
  - id: log_output
    type: ['null', File]
    doc: "Log file (when log_file is set)"
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
