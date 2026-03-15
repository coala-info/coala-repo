cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CollectQualityYieldMetrics
label: picard_CollectQualityYieldMetrics
doc: Collect metrics about reads that pass quality thresholds and 
  Illumina-specific filters. This tool evaluates the overall quality of reads 
  within a bam file containing one read group. The output indicates the total 
  numbers of bases within a read group that pass a minimum base quality score 
  threshold and (in the case of Illumina data) pass Illumina quality filters.
inputs:
  - id: input
    type: File
    doc: Input SAM/BAM/CRAM file.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output
    type: string
    doc: The file to write the output to.
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line This 
      argument may be specified 0 or more times.
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: assume_sorted
    type:
      - 'null'
      - boolean
    doc: If true (default), then the sort order in the header file will be 
      ignored.
    inputBinding:
      position: 101
      prefix: --ASSUME_SORTED
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
  - id: flow_mode
    type:
      - 'null'
      - boolean
    doc: Obsolete. FLOW_MODE support now provided by 
      CollectQualityYieldMetricsFlow
    inputBinding:
      position: 101
      prefix: --FLOW_MODE
  - id: include_secondary_alignments
    type:
      - 'null'
      - boolean
    doc: If true, include bases from secondary alignments in metrics. Setting to
      true may cause double-counting of bases if there are secondary alignments 
      in the input file.
    inputBinding:
      position: 101
      prefix: --INCLUDE_SECONDARY_ALIGNMENTS
  - id: include_supplemental_alignments
    type:
      - 'null'
      - boolean
    doc: If true, include bases from supplemental alignments in metrics. Setting
      to true may cause double-counting of bases if there are supplemental 
      alignments in the input file.
    inputBinding:
      position: 101
      prefix: --INCLUDE_SUPPLEMENTAL_ALIGNMENTS
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
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
  - id: stop_after
    type:
      - 'null'
      - int
    doc: Stop after processing N reads, mainly for debugging.
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
  - id: use_original_qualities
    type:
      - 'null'
      - boolean
    doc: If available in the OQ tag, use the original quality scores as inputs 
      instead of the quality scores in the QUAL field.
    inputBinding:
      position: 101
      prefix: --USE_ORIGINAL_QUALITIES
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
    doc: The file to write the output to.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
