cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - PositionBasedDownsampleSam
label: picard_PositionBasedDownsampleSam
doc: "Class to downsample a SAM/BAM/CRAM file based on the position of the read in
  a flowcell. As with DownsampleSam, all the reads with the same queryname are either
  kept or dropped as a unit.\n\nTool homepage: http://broadinstitute.github.io/picard/"
inputs:
  - id: allow_multiple_downsampling_despite_warnings
    type:
      - 'null'
      - boolean
    doc: Allow downsampling again despite this being a bad idea with possibly 
      unexpected results.
    default: false
    inputBinding:
      position: 101
      prefix: --ALLOW_MULTIPLE_DOWNSAMPLING_DESPITE_WARNINGS
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
  - id: fraction
    type: float
    doc: The (approximate) fraction of reads to be kept, between 0 and 1.
    inputBinding:
      position: 101
      prefix: --FRACTION
  - id: input
    type: File
    doc: The input SAM/BAM/CRAM file to downsample.
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
  - id: read_name_regex
    type:
      - 'null'
      - string
    doc: 'Use these regular expressions to parse read names in the input SAM file.
      Read names are parsed to extract three variables: tile/region, x coordinate
      and y coordinate.'
    inputBinding:
      position: 101
      prefix: --READ_NAME_REGEX
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: remove_duplicate_information
    type:
      - 'null'
      - boolean
    doc: Determines whether the duplicate tag should be reset since the 
      downsampling requires re-marking duplicates.
    default: true
    inputBinding:
      position: 101
      prefix: --REMOVE_DUPLICATE_INFORMATION
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    default: false
    inputBinding:
      position: 101
      prefix: --showHidden
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
    type: File
    doc: The output, downsampled, SAM/BAM/CRAM file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
