cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - IntervalListTools
label: picard_IntervalListTools
doc: "A tool for performing various IntervalList manipulations including sorting,
  merging, subtracting, padding, and other set-theoretic operations.\n\nTool homepage:
  http://broadinstitute.github.io/picard/"
inputs:
  - id: action
    type:
      - 'null'
      - string
    doc: 'Action to take on inputs: CONCAT, UNION, INTERSECT, SUBTRACT, SYMDIFF, OVERLAPS.'
    default: CONCAT
    inputBinding:
      position: 101
      prefix: --ACTION
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: break_bands_at_multiples_of
    type:
      - 'null'
      - int
    doc: If set to a positive value will create a new interval list with the 
      original intervals broken up at integer multiples of this value.
    default: 0
    inputBinding:
      position: 101
      prefix: --BREAK_BANDS_AT_MULTIPLES_OF
  - id: comment
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more lines of comment to add to the header of the output file.
    inputBinding:
      position: 101
      prefix: --COMMENT
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
  - id: dont_merge_abutting
    type:
      - 'null'
      - boolean
    doc: If false, do not merge abutting intervals (keep them separate).
    default: false
    inputBinding:
      position: 101
      prefix: --DONT_MERGE_ABUTTING
  - id: include_filtered
    type:
      - 'null'
      - boolean
    doc: Whether to include filtered variants in the vcf when generating an 
      interval list from vcf.
    default: false
    inputBinding:
      position: 101
      prefix: --INCLUDE_FILTERED
  - id: input
    type:
      type: array
      items: File
    doc: One or more interval lists. Supported formats are interval_list and 
      VCF.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Produce the inverse list of intervals, that is, the regions in the 
      genome that are not covered by any of the input intervals.
    default: false
    inputBinding:
      position: 101
      prefix: --INVERT
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
  - id: output_value
    type:
      - 'null'
      - string
    doc: What value to output to COUNT_OUTPUT file or stdout (NONE, BASES, 
      INTERVALS).
    default: NONE
    inputBinding:
      position: 101
      prefix: --OUTPUT_VALUE
  - id: padding
    type:
      - 'null'
      - int
    doc: The amount to pad each end of the intervals by before other operations 
      are undertaken.
    default: 0
    inputBinding:
      position: 101
      prefix: --PADDING
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
  - id: scatter_content
    type:
      - 'null'
      - int
    doc: When scattering with this argument, each of the resultant files will 
      (ideally) have this amount of 'content' (base-counts or interval-counts).
    inputBinding:
      position: 101
      prefix: --SCATTER_CONTENT
  - id: scatter_count
    type:
      - 'null'
      - int
    doc: The number of files into which to scatter the resulting list by locus.
    default: 1
    inputBinding:
      position: 101
      prefix: --SCATTER_COUNT
  - id: second_input
    type:
      - 'null'
      - type: array
        items: File
    doc: Second set of intervals for SUBTRACT and DIFFERENCE operations.
    inputBinding:
      position: 101
      prefix: --SECOND_INPUT
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    default: false
    inputBinding:
      position: 101
      prefix: --showHidden
  - id: sort
    type:
      - 'null'
      - boolean
    doc: If true, sort the resulting interval list by coordinate.
    default: true
    inputBinding:
      position: 101
      prefix: --SORT
  - id: subdivision_mode
    type:
      - 'null'
      - string
    doc: The mode used to scatter the interval list.
    default: INTERVAL_SUBDIVISION
    inputBinding:
      position: 101
      prefix: --SUBDIVISION_MODE
  - id: tmp_dir
    type:
      - 'null'
      - type: array
        items: Directory
    doc: One or more directories with space available to be used by this program
      for temporary storage of working files.
    inputBinding:
      position: 101
      prefix: --TMP_DIR
  - id: unique
    type:
      - 'null'
      - boolean
    doc: If true, merge overlapping and adjacent intervals to create a list of 
      unique intervals. Implies SORT=true.
    default: false
    inputBinding:
      position: 101
      prefix: --UNIQUE
  - id: use_jdk_deflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Deflater instead of the Intel Deflater for writing 
      compressed output.
    default: false
    inputBinding:
      position: 101
      prefix: --USE_JDK_DEFLATER
  - id: use_jdk_inflater
    type:
      - 'null'
      - boolean
    doc: Use the JDK Inflater instead of the Intel Inflater for reading 
      compressed input.
    default: false
    inputBinding:
      position: 101
      prefix: --USE_JDK_INFLATER
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: Validation stringency for all SAM files read by this program (STRICT, 
      LENIENT, SILENT).
    default: STRICT
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Control verbosity of logging (ERROR, WARNING, INFO, DEBUG).
    default: INFO
    inputBinding:
      position: 101
      prefix: --VERBOSITY
outputs:
  - id: count_output
    type:
      - 'null'
      - File
    doc: File to which to print count of bases or intervals in final output 
      interval list.
    outputBinding:
      glob: $(inputs.count_output)
  - id: output
    type:
      - 'null'
      - File
    doc: The output interval list file to write (if SCATTER_COUNT == 1) or the 
      directory into which to write the scattered interval sub-directories (if 
      SCATTER_COUNT > 1).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
