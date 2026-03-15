cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectIndependentReplicateMetrics
label: picard_CollectIndependentReplicateMetrics
doc: Estimates the rate of independent replication rate of reads within a bam. 
  This tool estimates the fraction of the input reads which would be marked as 
  duplicates but are actually biological replicates, independent observations of
  the data.
inputs:
  - id: input
    type: File
    doc: Input (indexed) BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output
    type: string
    doc: Write metrics to this file
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: vcf
    type:
      - 'null'
      - File
    doc: Input VCF file
    inputBinding:
      position: 101
      prefix: --VCF
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: barcode_bq
    type:
      - 'null'
      - string
    doc: Barcode Quality SAM tag.
    inputBinding:
      position: 101
      prefix: --BARCODE_BQ
  - id: barcode_tag
    type:
      - 'null'
      - string
    doc: Barcode SAM tag.
    inputBinding:
      position: 101
      prefix: --BARCODE_TAG
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level for all compressed files created (e.g. BAM and VCF).
    inputBinding:
      position: 101
      prefix: --COMPRESSION_LEVEL
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: Whether to create an index when writing VCF or coordinate sorted BAM 
      output.
    inputBinding:
      position: 101
      prefix: --CREATE_INDEX
  - id: create_md5_file
    type:
      - 'null'
      - boolean
    doc: Whether to create an MD5 digest for any BAM or FASTQ files created.
    inputBinding:
      position: 101
      prefix: --CREATE_MD5_FILE
  - id: filter_unpaired_reads
    type:
      - 'null'
      - boolean
    doc: Whether to filter unpaired reads from the input.
    inputBinding:
      position: 101
      prefix: --FILTER_UNPAIRED_READS
  - id: matrix_output
    type: string
    doc: Write the confusion matrix (of UMIs) to this file
    inputBinding:
      position: 101
      prefix: --MATRIX_OUTPUT
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: minimum_barcode_bq
    type:
      - 'null'
      - int
    doc: minimal value for the base quality of all the bases in a molecular 
      barcode, for it to be used.
    inputBinding:
      position: 101
      prefix: --MINIMUM_BARCODE_BQ
  - id: minimum_bq
    type:
      - 'null'
      - int
    doc: minimal value for the base quality of a base to be used in the 
      estimation.
    inputBinding:
      position: 101
      prefix: --MINIMUM_BQ
  - id: minimum_gq
    type:
      - 'null'
      - int
    doc: minimal value for the GQ field in the VCF to use variant site.
    inputBinding:
      position: 101
      prefix: --MINIMUM_GQ
  - id: minimum_mq
    type:
      - 'null'
      - int
    doc: minimal value for the mapping quality of the reads to be used in the 
      estimation.
    inputBinding:
      position: 101
      prefix: --MINIMUM_MQ
  - id: progress_step_interval
    type:
      - 'null'
      - int
    doc: The interval between which progress will be displayed.
    inputBinding:
      position: 101
      prefix: --PROGRESS_STEP_INTERVAL
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: sample
    type:
      - 'null'
      - string
    doc: Name of sample to look at in VCF. Can be omitted if VCF contains only 
      one sample.
    inputBinding:
      position: 101
      prefix: --SAMPLE
  - id: stop_after
    type:
      - 'null'
      - int
    doc: Number of sets to examine before stopping.
    inputBinding:
      position: 101
      prefix: --STOP_AFTER
  - id: tmp_dir
    type:
      - 'null'
      - type: array
        items: Directory
    doc: One or more directories with space available to be used by this program
      for temporary storage of working files
    inputBinding:
      position: 101
      prefix: --TMP_DIR
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Deflater instead of the Intel Deflater for writing 
      compressed output
    inputBinding:
      position: 101
      prefix: --USE_JDK_DEFLATER
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Inflater instead of the Intel Inflater for reading 
      compressed input
    inputBinding:
      position: 101
      prefix: --USE_JDK_INFLATER
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for all SAM files read by this program. Possible values:
      {STRICT, LENIENT, SILENT}'
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    inputBinding:
      position: 101
      prefix: --showHidden
outputs:
  - id: output_output
    type: File
    doc: Write metrics to this file
    outputBinding:
      glob: $(inputs.output)
  - id: output_matrix_output
    type:
      - 'null'
      - File
    doc: Write the confusion matrix (of UMIs) to this file
    outputBinding:
      glob: $(inputs.matrix_output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
