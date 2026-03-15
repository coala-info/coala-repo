cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - SplitSamByNumberOfReads
label: picard_SplitSamByNumberOfReads
doc: Splits a SAM/BAM/CRAM file to multiple files. This tool splits the input 
  query-grouped SAM/BAM/CRAM file into multiple files while maintaining the sort
  order. This can be used to split a large unmapped input in order to 
  parallelize alignment. It will traverse the input twice unless 
  TOTAL_READS_IN_INPUT is provided.
inputs:
  - id: input
    type: File
    doc: Input SAM/BAM/CRAM file to split
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output
    type: string
    doc: Directory in which to output the split BAM files.
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
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
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: Output files will be named <OUT_PREFIX>_N.EXT, where N enumerates the 
      output file and EXT is the same as that of the input.
    inputBinding:
      position: 101
      prefix: --OUT_PREFIX
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
  - id: split_to_n_files
    type:
      - 'null'
      - int
    doc: Split to N files. Cannot be used in conjunction with argument(s) 
      SPLIT_TO_N_READS (N_READS)
    inputBinding:
      position: 101
      prefix: --SPLIT_TO_N_FILES
  - id: split_to_n_reads
    type:
      - 'null'
      - int
    doc: Split to have approximately N reads per output file.
    inputBinding:
      position: 101
      prefix: --SPLIT_TO_N_READS
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
  - id: total_reads_in_input
    type:
      - 'null'
      - int
    doc: Total number of reads in the input file. If this is not provided, the 
      input will be read twice.
    inputBinding:
      position: 101
      prefix: --TOTAL_READS_IN_INPUT
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
    type: Directory
    doc: Directory in which to output the split BAM files.
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
