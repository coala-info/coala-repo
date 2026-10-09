cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq
  - correct
label: isoseq3_correct
doc: "Correct group barcodes given a barcode truth set\n\nTool homepage: https://github.com/PacificBiosciences/IsoSeq3"
inputs:
  - id: input_flnc
    type: File
    doc: "Input flnc BAM."
    inputBinding:
      position: 1
  - id: output_bccorr
    type: string
    default: flnc_bccorr.bam
    doc: "Output barcode-corrected flnc BAM."
    inputBinding:
      position: 2
  - id: barcodes
    type: ['null', File]
    doc: "Plain text file containing known 'true' barcodes, one per line. This 'include list' specifies the barcode-set to which raw cell barcodes are remapped by minimum edit distance. May be gzip-compressed."
    inputBinding:
      position: 103
      prefix: --barcodes
  - id: max_edit_distance
    type: ['null', int]
    doc: "Maximum edit distance for mapping barcodes to those in the truth set. Increasing this parameter will increase yield but potentially introduce errors."
    inputBinding:
      position: 103
      prefix: --max-edit-distance
  - id: filter
    type:
      - 'null'
      - type: enum
        symbols:
          - missing
          - failing
          - none
    doc: "Filtering mode. Set to 'missing' to remove reads which could not be corrected, and 'failing' to remove those as well as reads failing max-edit-distance thresholding."
    inputBinding:
      position: 103
      prefix: --filter
  - id: percentile
    type: ['null', int]
    doc: "Percentile to use when calculating real vs non-real cells. This option is only relevant when --method is set to 'percentile'."
    inputBinding:
      position: 103
      prefix: --percentile
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
  - id: corrected_bam
    type: File
    doc: "Barcode-corrected FLNC BAM."
    outputBinding:
      glob: $(inputs.output_bccorr)
  - id: other_outputs
    type:
      type: array
      items: File
    doc: "Other result files with the same prefix (BAM index, JSON report)."
    outputBinding:
      glob: $(inputs.output_bccorr.replace(/\.bam$/, '')).*
  - id: log_file
    type: ['null', File]
    doc: "Log file, when log_file_path is set."
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: TMPDIR
        envValue: "/tmp/"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
