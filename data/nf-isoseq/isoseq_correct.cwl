cwlVersion: v1.2
class: CommandLineTool
baseCommand: isoseq correct
label: isoseq_correct
doc: "Correct group barcodes given a barcode truth set\n\nTool homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs:
  - id: input_flnc
    type: string
    doc: Input flnc BAM, ConsensusReadSet XML, or FOFN
    inputBinding:
      position: 1
  - id: output_flnc_bccorr
    type: string
    doc: Output Barcode-corrected flnc BAM or ConsensusReadSet XML
    inputBinding:
      position: 2
  - id: barcodes
    type:
      - 'null'
      - string
    doc: Plain text file containing known 'true' barcodes, one per line. This 
      'include list' specifies the barcode-set to which raw cell barcodes are 
      remapped by minimum edit distance. May be gzip-compressed.
    inputBinding:
      position: 103
      prefix: --barcodes
  - id: filter
    type:
      - 'null'
      - string
    doc: "Filtering mode. Set to 'missing' to remove reads which could not be corrected,
      and 'failing' to remove those as well as reads failing max-edit-distance thresholding.
      Valid choices: (missing, failing, none)."
    inputBinding:
      position: 103
      prefix: --filter
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
    inputBinding:
      position: 103
      prefix: --log-level
  - id: max_edit_distance
    type:
      - 'null'
      - int
    doc: Maximum edit distance for mapping barcodes to those in the truth set. 
      Increasing this parameter will increase yield but potentially introduce 
      errors.
    inputBinding:
      position: 103
      prefix: --max-edit-distance
  - id: method
    type:
      - 'null'
      - string
    doc: "Whether to determine real vs non-real cells using Knee-finding ('knee')
      or Percentile-based method ('percentile'). Valid choices: (knee, percentile)."
    inputBinding:
      position: 103
      prefix: --method
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 103
      prefix: --num-threads
  - id: percentile
    type:
      - 'null'
      - int
    doc: Percentile to use when calculating real vs non-real cells. This option 
      is only relevant when --method is set to 'percentile'.
    inputBinding:
      position: 103
      prefix: --percentile
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Use verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq:4.3.0--h9ee0642_0
stdout: isoseq_correct.out
