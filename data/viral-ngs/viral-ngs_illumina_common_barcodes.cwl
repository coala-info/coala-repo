cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - illumina.py
  - common_barcodes
label: viral-ngs_illumina_common_barcodes
doc: "Extract Illumina barcodes for a run and write a TSV report of the barcode counts in descending order\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_dir
    type:
      - File
      - Directory
    doc: "Illumina BCL directory (or tar.gz of BCL directory). This is the top-level run directory."
    inputBinding:
      position: 1
  - id: lane
    type: int
    doc: "Lane number."
    inputBinding:
      position: 2
  - id: out_summary
    type: string
    doc: "Path to the summary file (.tsv format). It includes two columns: (barcode, count)"
    inputBinding:
      position: 3
  - id: truncate_to_length
    type:
      - 'null'
      - int
    doc: "If specified, only this number of barcodes will be returned. Useful if you only want the top N barcodes."
    inputBinding:
      position: 20
      prefix: --truncateToLength
  - id: omit_header
    type:
      - 'null'
      - boolean
    doc: "If specified, a header will not be added to the outSummary tsv file."
    inputBinding:
      position: 20
      prefix: --omitHeader
  - id: include_noise
    type:
      - 'null'
      - boolean
    doc: "If specified, barcodes with periods (\".\") will be included."
    inputBinding:
      position: 20
      prefix: --includeNoise
  - id: out_metrics
    type:
      - 'null'
      - string
    doc: "Output ExtractIlluminaBarcodes metrics file. Default is to dump to a temp file."
    inputBinding:
      position: 20
      prefix: --outMetrics
  - id: sample_sheet
    type:
      - 'null'
      - File
    doc: "Override SampleSheet. Input tab or CSV file w/header and four named columns: barcode_name, library_name, barcode_sequence_1, barcode_sequence_2. Default is to look for a SampleSheet.csv in the inDir."
    inputBinding:
      position: 20
      prefix: --sampleSheet
  - id: flowcell
    type:
      - 'null'
      - string
    doc: "Override flowcell ID (default: read from RunInfo.xml)."
    inputBinding:
      position: 20
      prefix: --flowcell
  - id: read_structure
    type:
      - 'null'
      - string
    doc: "Override read structure (default: read from RunInfo.xml)."
    inputBinding:
      position: 20
      prefix: --read_structure
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: "Picard ExtractIlluminaBarcodes MAX_MISMATCHES (default: 0)"
    inputBinding:
      position: 20
      prefix: --max_mismatches
  - id: minimum_base_quality
    type:
      - 'null'
      - int
    doc: "Picard ExtractIlluminaBarcodes MINIMUM_BASE_QUALITY (default: 25)"
    inputBinding:
      position: 20
      prefix: --minimum_base_quality
  - id: min_mismatch_delta
    type:
      - 'null'
      - int
    doc: "Picard ExtractIlluminaBarcodes MIN_MISMATCH_DELTA (default: None)"
    inputBinding:
      position: 20
      prefix: --min_mismatch_delta
  - id: max_no_calls
    type:
      - 'null'
      - int
    doc: "Picard ExtractIlluminaBarcodes MAX_NO_CALLS (default: None)"
    inputBinding:
      position: 20
      prefix: --max_no_calls
  - id: minimum_quality
    type:
      - 'null'
      - int
    doc: "Picard ExtractIlluminaBarcodes MINIMUM_QUALITY (default: None)"
    inputBinding:
      position: 20
      prefix: --minimum_quality
  - id: compress_outputs
    type:
      - 'null'
      - string
    doc: "Picard ExtractIlluminaBarcodes COMPRESS_OUTPUTS (default: None)"
    inputBinding:
      position: 20
      prefix: --compress_outputs
  - id: jvm_memory
    type:
      - 'null'
      - string
    doc: "JVM virtual memory size (default: 8g)"
    inputBinding:
      position: 20
      prefix: --JVMmemory
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 20
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 20
      prefix: --tmp_dirKeep
outputs:
  - id: out_summary_file
    type: File
    doc: "Output file written to out_summary"
    outputBinding:
      glob: $(inputs.out_summary)
  - id: out_metrics_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_metrics"
    outputBinding:
      glob: $(inputs.out_metrics)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
