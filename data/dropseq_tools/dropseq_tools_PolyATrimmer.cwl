cwlVersion: v1.2
class: CommandLineTool
baseCommand: PolyATrimmer
label: dropseq_tools_PolyATrimmer
doc: "Trims poly-A tails from SAM/BAM files.\n\nTool homepage: http://mccarrolllab.com/dropseq/"
inputs:
  - id: adapter
    type:
      - 'null'
      - string
    doc: Symbolic & literal specification of adapter sequence. This is a 
      combination of fixed bases to match, and references to SAMRecord tag 
      values. E.g. '~XM^XCACGT' means 'RCed value of XM tag' + 'value of XC tag'
      + 'ACGT'. Ideally this is at least as long as the read (new trim algo)
    default: ~XM~XC
    inputBinding:
      position: 101
      prefix: --ADAPTER
  - id: adapter_tag
    type:
      - 'null'
      - string
    doc: Tag in which length of adapter is stored. Not set if adapter length==0.
    default: 'null'
    inputBinding:
      position: 101
      prefix: --ADAPTER_TAG
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    default: 'null'
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
  - id: dubious_adapter_match_length
    type:
      - 'null'
      - int
    doc: If adapter match is at end of read, with fewer than this many bases 
      matching the read, and not enough poly A is found preceding it, then 
      ignore the adapter match and try again from the end of the read (new trim 
      algo)
    default: 6
    inputBinding:
      position: 101
      prefix: --DUBIOUS_ADAPTER_MATCH_LENGTH
  - id: input_file
    type: File
    doc: The input SAM or BAM file to analyze.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: jvm_heap_size
    type:
      - 'null'
      - string
    doc: Heap size to allocate for the JVM.
    default: 4g
    inputBinding:
      position: 101
      prefix: -m
  - id: length_tag
    type:
      - 'null'
      - string
    doc: Tag in which length of polyA is stored. Not set if polyA length==0.
    default: 'null'
    inputBinding:
      position: 101
      prefix: --LENGTH_TAG
  - id: max_adapter_error_rate
    type:
      - 'null'
      - float
    doc: Fraction of bases that can mismatch when looking for adapter match (new
      trim algo)
    default: 0.1
    inputBinding:
      position: 101
      prefix: --MAX_ADAPTER_ERROR_RATE
  - id: max_poly_a_error_rate
    type:
      - 'null'
      - float
    doc: When looking for poly A, allow this fraction of bases not to be A (new 
      trim algo)
    default: 0.1
    inputBinding:
      position: 101
      prefix: --MAX_POLY_A_ERROR_RATE
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk. Increasing this number 
      reduces the number of file handles needed to sort the file, and increases 
      the amount of RAM needed.
    default: 500000
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: min_adapter_match
    type:
      - 'null'
      - int
    doc: Minimum number of bases for adapter match (new trim algo)
    default: 4
    inputBinding:
      position: 101
      prefix: --MIN_ADAPTER_MATCH
  - id: min_poly_a_length
    type:
      - 'null'
      - int
    doc: Minimum length of a poly A run, except when start of end of read 
      intervenes (new trim algo)
    default: 20
    inputBinding:
      position: 101
      prefix: --MIN_POLY_A_LENGTH
  - id: min_poly_a_length_no_adapter_match
    type:
      - 'null'
      - int
    doc: Minimum length of poly A run at end of read, if there is no adapter 
      match (new trim algo)
    default: 6
    inputBinding:
      position: 101
      prefix: --MIN_POLY_A_LENGTH_NO_ADAPTER_MATCH
  - id: mismatches
    type:
      - 'null'
      - int
    doc: How many mismatches are acceptable in the sequence (old trim algo).
    default: 0
    inputBinding:
      position: 101
      prefix: --MISMATCHES
  - id: num_bases
    type:
      - 'null'
      - int
    doc: How many bases of polyA qualifies as a run of A's (old trim algo).
    default: 6
    inputBinding:
      position: 101
      prefix: --NUM_BASES
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
    default: 'null'
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
    default: 'null'
    inputBinding:
      position: 101
      prefix: --TMP_DIR
  - id: trim_tag
    type:
      - 'null'
      - string
    doc: The tag to set for trimmed reads. This tags the first base to exclude 
      in the read. 37 would mean to retain the first 36 bases.
    default: ZP
    inputBinding:
      position: 101
      prefix: --TRIM_TAG
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
  - id: use_new_trimmer
    type:
      - 'null'
      - boolean
    doc: The old polyA trimmer looks for the longest run of As that is at least 
      NUM_BASES long and has no more than MISMATCHES bases that are not A. For 
      the new polyA trimmer, it is assumed that the polyA run either extends to 
      the end of the read, or to the beginning of adapter sequence at the end of
      the read. If the entire read is adapter sequence, the entire read is 
      trimmed by setting all base qualities low. If adapter sequence was found, 
      the polyA run must be at least MIN_POLY_A_LENGTH long. If no adapter 
      sequence was found, the polyA run must be at least 
      MIN_POLY_A_LENGTH_NO_ADAPTER_MATCH long, on the assumption that the polyA 
      tail may extend beyond the end of the read. The fraction of allowed non-A 
      bases in a polyA run must be <= MAX_POLY_A_ERROR_RATE.
    default: false
    inputBinding:
      position: 101
      prefix: --USE_NEW_TRIMMER
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: Validation stringency for all SAM files read by this program. Setting 
      stringency to SILENT can improve performance when processing a BAM file in
      which variable-length data (read, qualities, tags) do not otherwise need 
      to be decoded.
    default: STRICT
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Echo final command line before executing.
    inputBinding:
      position: 101
      prefix: -v
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Control verbosity of logging.
    default: INFO
    inputBinding:
      position: 101
      prefix: --VERBOSITY
outputs:
  - id: output_file
    type: File
    doc: The output BAM file
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_summary
    type:
      - 'null'
      - File
    doc: The output summary statistics
    outputBinding:
      glob: $(inputs.output_summary)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropseq_tools:3.0.2--hdfd78af_0
