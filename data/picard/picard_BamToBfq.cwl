cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - BamToBfq
label: picard_BamToBfq
doc: Converts a BAM file into a BFQ (binary fastq formatted) file. The BFQ 
  format is the input format to some tools like Maq aligner.
inputs:
  - id: analysis_dir
    type: string
    doc: The analysis directory for the binary output file.
    inputBinding:
      position: 101
      prefix: --ANALYSIS_DIR
  - id: flowcell_barcode
    type: string
    doc: Flowcell barcode (e.g. 30PYMAAXX). Cannot be used in conjunction with 
      argument(s) OUTPUT_FILE_PREFIX
    inputBinding:
      position: 101
      prefix: --FLOWCELL_BARCODE
  - id: input
    type:
      - 'null'
      - File
    doc: The BAM file to parse.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output_file_prefix
    type: string
    doc: Prefix for all output files. Cannot be used in conjunction with 
      argument(s) FLOWCELL_BARCODE (F) LANE (L)
    inputBinding:
      position: 101
      prefix: --OUTPUT_FILE_PREFIX
  - id: paired_run
    type: boolean
    doc: 'Whether this is a paired-end run. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --PAIRED_RUN
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: bases_to_write
    type:
      - 'null'
      - int
    doc: The number of bases from each read to write to the bfq file. If this is
      non-null, then only the first BASES_TO_WRITE bases from each read will be 
      written.
    inputBinding:
      position: 101
      prefix: --BASES_TO_WRITE
  - id: clip_adapters
    type:
      - 'null'
      - boolean
    doc: Whether to clip adapters from the reads
    inputBinding:
      position: 101
      prefix: --CLIP_ADAPTERS
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
  - id: include_non_pf_reads
    type:
      - 'null'
      - boolean
    doc: Whether to include non-PF reads
    inputBinding:
      position: 101
      prefix: --INCLUDE_NON_PF_READS
  - id: lane
    type:
      - 'null'
      - int
    doc: Lane number. Cannot be used in conjunction with argument(s) 
      OUTPUT_FILE_PREFIX
    inputBinding:
      position: 101
      prefix: --LANE
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
  - id: read_chunk_size
    type:
      - 'null'
      - int
    doc: Number of reads to break into individual groups for alignment
    inputBinding:
      position: 101
      prefix: --READ_CHUNK_SIZE
  - id: read_name_prefix
    type:
      - 'null'
      - string
    doc: Prefix to be stripped off the beginning of all read names (to make them
      short enough to run in Maq). Cannot be used in conjunction with 
      argument(s) RUN_BARCODE (RB)
    inputBinding:
      position: 101
      prefix: --READ_NAME_PREFIX
  - id: reads_to_align
    type:
      - 'null'
      - int
    doc: Number of reads to align (null = all).
    inputBinding:
      position: 101
      prefix: --READS_TO_ALIGN
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: run_barcode
    type:
      - 'null'
      - string
    doc: Deprecated option; use READ_NAME_PREFIX instead. Cannot be used in 
      conjunction with argument(s) READ_NAME_PREFIX
    inputBinding:
      position: 101
      prefix: --RUN_BARCODE
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
  - id: output_analysis_dir
    type: Directory
    doc: The analysis directory for the binary output file.
    outputBinding:
      glob: $(inputs.analysis_dir)
  - id: output_output_file_prefix
    type: File
    doc: Prefix for all output files. Cannot be used in conjunction with 
      argument(s) FLOWCELL_BARCODE (F) LANE (L)
    outputBinding:
      glob: $(inputs.output_file_prefix)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
