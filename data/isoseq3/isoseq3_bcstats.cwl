cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq
  - bcstats
label: isoseq3_bcstats
doc: "Generates stats for group barcodes and (optionally) molecular barcodes\n\nTool
  homepage: https://github.com/PacificBiosciences/IsoSeq3"
inputs:
  - id: input_file
    type: string
    doc: Input BAM, ConsensusReadSet XML, or FOFN
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size for processing.
    inputBinding:
      position: 102
      prefix: --batch-size
  - id: deduplicated
    type:
      - 'null'
      - boolean
    doc: To mark as de-duplicated. This allows for faster analysis and sanity 
      checks across versions.
    inputBinding:
      position: 102
      prefix: --deduplicated
  - id: emit_molecular_stats
    type:
      - 'null'
      - boolean
    doc: Emit stats for molecular barcodes (UMIs) as well as cell barcodes. This
      results in a tsv with one line for each cell barcode and one line for each
      molecular barcode.
    inputBinding:
      position: 102
      prefix: --molecular
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
    doc: Set log level.
    inputBinding:
      position: 102
      prefix: --log-level
  - id: method
    type:
      - 'null'
      - string
    doc: Whether to determine real vs non-real cells using Knee-finding ('knee')
      or Percentile-based method ('percentile').
    inputBinding:
      position: 102
      prefix: --method
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    inputBinding:
      position: 102
      prefix: --num-threads
  - id: percentile
    type:
      - 'null'
      - int
    doc: Percentile to use when calculating real vs non-real cells. This option 
      is only relevant when --method is set to 'percentile'.
    inputBinding:
      position: 102
      prefix: --percentile
  - id: target
    type:
      - 'null'
      - string
    doc: Whether to determine real vs non-real cells by read count ('readcount')
      or UMI count ('umicount').
    inputBinding:
      position: 102
      prefix: --target
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Use verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_tsv
    type:
      - 'null'
      - File
    doc: Output tsv of stats for input BAM files.
    outputBinding:
      glob: $(inputs.output_tsv)
  - id: output_json_report
    type:
      - 'null'
      - File
    doc: Path to emit output JSON report.
    outputBinding:
      glob: $(inputs.output_json_report)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
