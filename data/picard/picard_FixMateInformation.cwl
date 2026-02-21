cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - FixMateInformation
label: picard_FixMateInformation
doc: "Verify mate-pair information between mates and fix if needed. This tool ensures
  that all mate-pair information is in sync between each read and its mate pair. If
  no OUTPUT file is supplied then the output is written to a temporary file and then
  copied over the INPUT file.\n\nTool homepage: http://broadinstitute.github.io/picard/"
inputs:
  - id: add_mate_cigar
    type:
      - 'null'
      - boolean
    doc: Adds the mate CIGAR tag (MC) if true, does not if false.
    default: true
    inputBinding:
      position: 101
      prefix: --ADD_MATE_CIGAR
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: assume_sorted
    type:
      - 'null'
      - boolean
    doc: If true, assume that the input file is queryname sorted, even if the 
      header says otherwise.
    default: false
    inputBinding:
      position: 101
      prefix: --ASSUME_SORTED
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level for all compressed files created (e.g. BAM and VCF).
    default: 5
    inputBinding:
      position: 101
      prefix: --COMPRESSION_LEVEL
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: Whether to create an index when writing VCF or coordinate sorted BAM 
      output.
    default: false
    inputBinding:
      position: 101
      prefix: --CREATE_INDEX
  - id: create_md5_file
    type:
      - 'null'
      - boolean
    doc: Whether to create an MD5 digest for any BAM or FASTQ files created.
    default: false
    inputBinding:
      position: 101
      prefix: --CREATE_MD5_FILE
  - id: ignore_missing_mates
    type:
      - 'null'
      - boolean
    doc: If true, ignore missing mates, otherwise will throw an exception when 
      missing mates are found.
    default: true
    inputBinding:
      position: 101
      prefix: --IGNORE_MISSING_MATES
  - id: input
    type:
      type: array
      items: File
    doc: The SAM/BAM/CRAM input files to check and fix. Multiple files will be 
      merged and sorted. This argument must be specified at least once.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    default: 500000
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    default: false
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
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    default: false
    inputBinding:
      position: 101
      prefix: --showHidden
  - id: sort_order
    type:
      - 'null'
      - string
    doc: 'Optional sort order if the OUTPUT file should be sorted differently than
      the INPUT file. Possible values: {unsorted, queryname, coordinate, duplicate,
      unknown}'
    inputBinding:
      position: 101
      prefix: --SORT_ORDER
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
    default: false
    inputBinding:
      position: 101
      prefix: --USE_JDK_DEFLATER
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Inflater instead of the Intel Inflater for reading 
      compressed input
    default: false
    inputBinding:
      position: 101
      prefix: --USE_JDK_INFLATER
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for all SAM files read by this program. Possible values:
      {STRICT, LENIENT, SILENT}'
    default: STRICT
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
  - id: verbosity
    type:
      - 'null'
      - string
    doc: 'Control verbosity of logging. Possible values: {ERROR, WARNING, INFO, DEBUG}'
    default: INFO
    inputBinding:
      position: 101
      prefix: --VERBOSITY
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The output file to write to. If no output file is supplied, the input 
      file is overwritten (only available with single input file).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
