cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - illumina.py
  - illumina_demux
label: viral-ngs_illumina_illumina_demux
doc: "Demultiplex Illumina runs & produce BAM files, one per sample. Wraps together Picard's ExtractBarcodes and IlluminaBasecallsToSam while handling the various required input formats. Also can read Illumina BCL directories, tar.gz BCL directories. TO DO: read BCL or tar.gz BCL directories from S3 / object store.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
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
  - id: out_dir
    type: string
    doc: "Output directory for BAM files."
    inputBinding:
      position: 3
  - id: out_metrics
    type:
      - 'null'
      - string
    doc: "Output ExtractIlluminaBarcodes metrics file. Default is to dump to a temp file."
    inputBinding:
      position: 20
      prefix: --outMetrics
  - id: common_barcodes
    type:
      - 'null'
      - string
    doc: "Write a TSV report of all barcode counts, in descending order."
    inputBinding:
      position: 20
      prefix: --commonBarcodes
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
  - id: sequencing_center
    type:
      - 'null'
      - string
    doc: "Picard IlluminaBasecallsToSam SEQUENCING_CENTER (default: None)"
    inputBinding:
      position: 20
      prefix: --sequencing_center
  - id: adapters_to_check
    type:
      - 'null'
      - type: array
        items: string
    doc: "Picard IlluminaBasecallsToSam ADAPTERS_TO_CHECK (default: ('PAIRED_END', 'NEXTERA_V1', 'NEXTERA_V2'))"
    inputBinding:
      position: 30
      prefix: --adapters_to_check
  - id: platform
    type:
      - 'null'
      - string
    doc: "Picard IlluminaBasecallsToSam PLATFORM (default: None)"
    inputBinding:
      position: 20
      prefix: --platform
  - id: max_reads_in_ram_per_tile
    type:
      - 'null'
      - int
    doc: "Picard IlluminaBasecallsToSam MAX_READS_IN_RAM_PER_TILE (default: 100000)"
    inputBinding:
      position: 20
      prefix: --max_reads_in_ram_per_tile
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: "Picard IlluminaBasecallsToSam MAX_RECORDS_IN_RAM (default: 100000)"
    inputBinding:
      position: 20
      prefix: --max_records_in_ram
  - id: num_processors
    type:
      - 'null'
      - int
    doc: "Picard IlluminaBasecallsToSam NUM_PROCESSORS (default: 4)"
    inputBinding:
      position: 20
      prefix: --num_processors
  - id: apply_eamss_filter
    type:
      - 'null'
      - string
    doc: "Picard IlluminaBasecallsToSam APPLY_EAMSS_FILTER (default: None)"
    inputBinding:
      position: 20
      prefix: --apply_eamss_filter
  - id: force_gc
    type:
      - 'null'
      - string
    doc: "Picard IlluminaBasecallsToSam FORCE_GC (default: False)"
    inputBinding:
      position: 20
      prefix: --force_gc
  - id: first_tile
    type:
      - 'null'
      - int
    doc: "Picard IlluminaBasecallsToSam FIRST_TILE (default: None)"
    inputBinding:
      position: 20
      prefix: --first_tile
  - id: tile_limit
    type:
      - 'null'
      - int
    doc: "Picard IlluminaBasecallsToSam TILE_LIMIT (default: None)"
    inputBinding:
      position: 20
      prefix: --tile_limit
  - id: include_non_pf_reads
    type:
      - 'null'
      - string
    doc: "Picard IlluminaBasecallsToSam INCLUDE_NON_PF_READS (default: False)"
    inputBinding:
      position: 20
      prefix: --include_non_pf_reads
  - id: run_start_date
    type:
      - 'null'
      - string
    doc: "Picard IlluminaBasecallsToSam RUN_START_DATE (default: None)"
    inputBinding:
      position: 20
      prefix: --run_start_date
  - id: read_group_id
    type:
      - 'null'
      - string
    doc: "Picard IlluminaBasecallsToSam READ_GROUP_ID (default: None)"
    inputBinding:
      position: 20
      prefix: --read_group_id
  - id: jvm_memory
    type:
      - 'null'
      - string
    doc: "JVM virtual memory size (default: 54g)"
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
  - id: out_dir_dir
    type: Directory
    doc: "Output directory out_dir"
    outputBinding:
      glob: $(inputs.out_dir)
  - id: out_metrics_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_metrics"
    outputBinding:
      glob: $(inputs.out_metrics)
  - id: common_barcodes_file
    type:
      - 'null'
      - File
    doc: "Output file written to common_barcodes"
    outputBinding:
      glob: $(inputs.common_barcodes)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
