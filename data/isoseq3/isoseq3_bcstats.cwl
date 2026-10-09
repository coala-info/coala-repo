cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq
  - bcstats
label: isoseq3_bcstats
doc: "Generates stats for group barcodes and (optionally) molecular barcodes\n\nTool homepage: https://github.com/PacificBiosciences/IsoSeq3"
inputs:
  - id: input_file
    type: File
    doc: "Input BAM."
    inputBinding:
      position: 100
  - id: output_tsv_path
    type: string
    default: bcstats.tsv
    doc: "Output tsv of stats for input BAM files."
    inputBinding:
      position: 101
      prefix: --output
  - id: output_json_path
    type: string
    default: bcstats.json
    doc: "Path to emit output JSON report."
    inputBinding:
      position: 102
      prefix: --json
  - id: molecular
    type: ['null', boolean]
    doc: "Emit stats for molecular barcodes (UMIs) as well as cell barcodes. This results in a tsv with one line for each cell barcode and one line for each molecular barcode."
    inputBinding:
      position: 103
      prefix: --molecular
  - id: deduplicated
    type: ['null', boolean]
    doc: "To mark as de-duplicated. This allows for faster analysis and sanity checks across versions."
    inputBinding:
      position: 103
      prefix: --deduplicated
  - id: batch_size
    type: ['null', int]
    doc: "Batch size for processing."
    inputBinding:
      position: 103
      prefix: --batch-size
  - id: percentile
    type: ['null', int]
    doc: "Percentile to use when calculating real vs non-real cells. This option is only relevant when --method is set to 'percentile'."
    inputBinding:
      position: 103
      prefix: --percentile
  - id: target
    type:
      - 'null'
      - type: enum
        symbols:
          - readcount
          - umicount
    doc: "Whether to determine real vs non-real cells by read count ('readcount') or UMI count ('umicount')."
    inputBinding:
      position: 103
      prefix: --target
  - id: method
    type:
      - 'null'
      - type: enum
        symbols:
          - knee
          - percentile
    doc: "Whether to determine real vs non-real cells using Knee-finding ('knee') or Percentile-based method ('percentile')."
    inputBinding:
      position: 103
      prefix: --method
  - id: num_threads
    type: ['null', int]
    doc: "Number of threads to use, 0 means autodetection."
    inputBinding:
      position: 103
      prefix: --num-threads
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
  - id: verbose
    type: ['null', boolean]
    doc: "Use verbose output."
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_tsv
    type: File
    doc: "Barcode statistics table."
    outputBinding:
      glob: $(inputs.output_tsv_path)
  - id: output_json
    type: File
    doc: "JSON report."
    outputBinding:
      glob: $(inputs.output_json_path)
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
