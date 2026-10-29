cwlVersion: v1.2
class: CommandLineTool
baseCommand: [isoseq, correct]
label: nf-isoseq_isoseq_correct
doc: "Correct group barcodes given a barcode truth set

Tool homepage: https://github.com/PacificBiosciences/pbbioconda"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: flnc_bam
    type: File
    doc: "Input flnc BAM, ConsensusReadSet XML, or FOFN"
    secondaryFiles:
      - pattern: .pbi
        required: false
    inputBinding:
      position: 1
  - id: corrected_output
    type: string
    doc: "Output barcode-corrected flnc BAM or ConsensusReadSet XML"
    inputBinding:
      position: 2
  - id: barcodes
    type: File
    doc: "Plain text file containing known 'true' barcodes, one per line (may be gzip-compressed)"
    inputBinding:
      position: 100
      prefix: --barcodes
  - id: max_edit_distance
    type: ['null', int]
    doc: "Maximum edit distance for mapping barcodes to those in the truth set. [2]"
    inputBinding:
      position: 100
      prefix: --max-edit-distance
  - id: filter
    type: ['null', string]
    doc: "Filtering mode: missing, failing or none. [none]"
    inputBinding:
      position: 100
      prefix: --filter
  - id: percentile
    type: ['null', int]
    doc: "Percentile to use when calculating real vs non-real cells (method percentile). [99]"
    inputBinding:
      position: 100
      prefix: --percentile
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
  - id: corrected_bam
    type: File
    doc: "Barcode-corrected flnc BAM"
    secondaryFiles:
      - pattern: .pbi
        required: false
    outputBinding:
      glob: $(inputs.corrected_output)
  - id: report_json
    type: ['null', File]
    doc: "Correction report"
    outputBinding:
      glob: $(inputs.corrected_output.replace(/\.(bam|xml)$/, '')).report.json
  - id: log_output
    type: ['null', File]
    doc: "Log file (when log_file is set)"
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
