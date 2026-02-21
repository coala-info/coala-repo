cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - FilterSamReads
label: picard_FilterSamReads
doc: "Subsets reads from a SAM/BAM/CRAM file by applying one of several filters such
  as aligned or unaligned reads, specific reads based on a list of reads names, an
  interval list, by Tag Values, or using a JavaScript script.\n\nTool homepage: http://broadinstitute.github.io/picard/"
inputs:
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
  - id: filter
    type: string
    doc: 'Which filter to use. Options: includeAligned, excludeAligned, includeReadList,
      excludeReadList, includeJavascript, includePairedIntervals, includeTagValues,
      excludeTagValues.'
    inputBinding:
      position: 101
      prefix: --FILTER
  - id: input
    type: File
    doc: The SAM/BAM/CRAM file that will be filtered.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: interval_list
    type:
      - 'null'
      - File
    doc: Interval List File containing intervals that will be included in the 
      OUTPUT when using FILTER=includePairedIntervals
    inputBinding:
      position: 101
      prefix: --INTERVAL_LIST
  - id: javascript_file
    type:
      - 'null'
      - File
    doc: Filters the INPUT with a javascript expression using the java 
      javascript-engine, when using FILTER=includeJavascript.
    inputBinding:
      position: 101
      prefix: --JAVASCRIPT_FILE
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
  - id: read_list_file
    type:
      - 'null'
      - File
    doc: File containing reads that will be included in or excluded from the 
      OUTPUT SAM/BAM/CRAM file, when using FILTER=includeReadList or 
      FILTER=excludeReadList.
    inputBinding:
      position: 101
      prefix: --READ_LIST_FILE
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
    doc: 'SortOrder of the OUTPUT file, otherwise use the SortOrder of the INPUT file.
      Possible values: {unsorted, queryname, coordinate, duplicate, unknown}'
    inputBinding:
      position: 101
      prefix: --SORT_ORDER
  - id: tag
    type:
      - 'null'
      - string
    doc: The tag to select from input SAM/BAM
    inputBinding:
      position: 101
      prefix: --TAG
  - id: tag_value
    type:
      - 'null'
      - type: array
        items: string
    doc: The tag value(s) to filter by
    inputBinding:
      position: 101
      prefix: --TAG_VALUE
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
  - id: write_reads_files
    type:
      - 'null'
      - boolean
    doc: Create <OUTPUT>.reads file containing names of reads from INPUT and 
      OUTPUT (for debugging purposes.)
    default: false
    inputBinding:
      position: 101
      prefix: --WRITE_READS_FILES
outputs:
  - id: output
    type: File
    doc: SAM/BAM/CRAM file for resulting reads.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
