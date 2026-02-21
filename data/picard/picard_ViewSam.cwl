cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - ViewSam
label: picard_ViewSam
doc: "Very simple command that just reads a SAM or BAM file and writes out the header
  and each record to standard out. When an (optional) intervals file is specified,
  only records overlapping those intervals will be output. All reads, just the aligned
  reads, or just the unaligned reads can be printed out by setting AlignmentStatus
  accordingly.\n\nTool homepage: http://broadinstitute.github.io/picard/"
inputs:
  - id: alignment_status
    type: string
    doc: 'Print out all reads, just the aligned reads or just the unaligned reads.
      Possible values: {Aligned, Unaligned, All}'
    inputBinding:
      position: 101
      prefix: --ALIGNMENT_STATUS
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
  - id: header_only
    type:
      - 'null'
      - boolean
    doc: Print the SAM header only.
    default: false
    inputBinding:
      position: 101
      prefix: --HEADER_ONLY
  - id: input
    type: File
    doc: The SAM or BAM file or GA4GH url to view.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: interval_list
    type:
      - 'null'
      - File
    doc: An intervals file used to restrict what records are output.
    inputBinding:
      position: 101
      prefix: --INTERVAL_LIST
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
  - id: pf_status
    type: string
    doc: 'Print out all reads, just the PF reads or just the non-PF reads. Possible
      values: {PF, NonPF, All}'
    inputBinding:
      position: 101
      prefix: --PF_STATUS
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    default: false
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: records_only
    type:
      - 'null'
      - boolean
    doc: Print the alignment records only.
    default: false
    inputBinding:
      position: 101
      prefix: --RECORDS_ONLY
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
stdout: picard_ViewSam.out
