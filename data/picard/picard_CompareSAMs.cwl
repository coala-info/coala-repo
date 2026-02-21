cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CompareSAMs
label: picard_CompareSAMs
doc: "Compare two input SAM/BAM/CRAM files. This tool initially compares the headers
  of the input files. If the file headers are comparable, the tool can perform either
  strict comparisons for which each alignment and the header must be identical, or
  a more lenient check of \"equivalence\". Results of comparison are summarised in
  an output metrics file.\n\nTool homepage: http://broadinstitute.github.io/picard/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Exactly two input SAM/BAM/CRAM files to compare to one another.
    inputBinding:
      position: 1
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 102
      prefix: --arguments_file
  - id: compare_mq
    type:
      - 'null'
      - boolean
    doc: If set to true, generate a histogram for mapping quality concordance 
      between the two SAM files and write it to the output metrics file.
    default: false
    inputBinding:
      position: 102
      prefix: --COMPARE_MQ
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level for all compressed files created (e.g. BAM and VCF).
    default: 5
    inputBinding:
      position: 102
      prefix: --COMPRESSION_LEVEL
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: Whether to create an index when writing VCF or coordinate sorted BAM 
      output.
    default: false
    inputBinding:
      position: 102
      prefix: --CREATE_INDEX
  - id: create_md5_file
    type:
      - 'null'
      - boolean
    doc: Whether to create an MD5 digest for any BAM or FASTQ files created.
    default: false
    inputBinding:
      position: 102
      prefix: --CREATE_MD5_FILE
  - id: lenient_dup
    type:
      - 'null'
      - boolean
    doc: Perform lenient checking of duplicate marks. In this mode, will reduce 
      the number of mismatches by allowing the choice of the representative read
      in each duplicate set to differ between the input files, as long as the 
      duplicate sets agree.
    default: false
    inputBinding:
      position: 102
      prefix: --LENIENT_DUP
  - id: lenient_header
    type:
      - 'null'
      - boolean
    doc: Perform lenient checking of header. In this mode, species, assembly, 
      ur, m5, fields of sequence records, and pg fields in the header may all 
      differ.
    default: false
    inputBinding:
      position: 102
      prefix: --LENIENT_HEADER
  - id: lenient_low_mq_alignment
    type:
      - 'null'
      - boolean
    doc: Count reads which have mapping quality below LOW_MQ_THRESHOLD in both 
      files but are mapped to different locations as matches.
    default: false
    inputBinding:
      position: 102
      prefix: --LENIENT_LOW_MQ_ALIGNMENT
  - id: lenient_unknown_mq_alignment
    type:
      - 'null'
      - boolean
    doc: Count reads for which no mapping quality is available (mapping quality 
      value 255) in both files but are mapped to different locations as matches.
    default: false
    inputBinding:
      position: 102
      prefix: --LENIENT_UNKNOWN_MQ_ALIGNMENT
  - id: low_mq_threshold
    type:
      - 'null'
      - int
    doc: When running in LENIENT_LOW_MQ_ALIGNMENT mode, reads which have mapping
      quality below this value will be counted as matches.
    default: 3
    inputBinding:
      position: 102
      prefix: --LOW_MQ_THRESHOLD
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    default: 500000
    inputBinding:
      position: 102
      prefix: --MAX_RECORDS_IN_RAM
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    default: false
    inputBinding:
      position: 102
      prefix: --QUIET
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    inputBinding:
      position: 102
      prefix: --REFERENCE_SEQUENCE
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    default: false
    inputBinding:
      position: 102
      prefix: --showHidden
  - id: tmp_dir
    type:
      - 'null'
      - type: array
        items: Directory
    doc: One or more directories with space available to be used by this program
      for temporary storage of working files
    inputBinding:
      position: 102
      prefix: --TMP_DIR
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Deflater instead of the Intel Deflater for writing 
      compressed output
    default: false
    inputBinding:
      position: 102
      prefix: --USE_JDK_DEFLATER
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Inflater instead of the Intel Inflater for reading 
      compressed input
    default: false
    inputBinding:
      position: 102
      prefix: --USE_JDK_INFLATER
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for all SAM files read by this program. Possible values:
      {STRICT, LENIENT, SILENT}'
    default: STRICT
    inputBinding:
      position: 102
      prefix: --VALIDATION_STRINGENCY
  - id: verbosity
    type:
      - 'null'
      - string
    doc: 'Control verbosity of logging. Possible values: {ERROR, WARNING, INFO, DEBUG}'
    default: INFO
    inputBinding:
      position: 102
      prefix: --VERBOSITY
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file to write comparison results to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
