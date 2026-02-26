cwlVersion: v1.2
class: CommandLineTool
baseCommand: TrimStartingSequence
label: dropseq_tools_TrimStartingSequence
doc: "Trim the given sequence from the beginning of reads\n\nTool homepage: http://mccarrolllab.com/dropseq/"
inputs:
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
  - id: echo_command
    type:
      - 'null'
      - boolean
    doc: Echo final command line before executing.
    inputBinding:
      position: 101
      prefix: -v
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
  - id: legacy
    type:
      - 'null'
      - boolean
    doc: Enable the old trim algorithm (release <= 2.4.0), which did not match 
      if bases precede the sequence, and had bugs if sequence was longer than 
      read length.
    default: false
    inputBinding:
      position: 101
      prefix: --LEGACY
  - id: length_tag
    type:
      - 'null'
      - string
    doc: Tag containing the length of sequence matched. If using MISMATCHES 
      algorithm, this will be the same value as stored in TRIM_TAG. If using 
      MISMATCH_RATE, full-length sequence will match even if something precedes 
      it, so this may be different than TRIM_TAG value. Not stored if not set.
    default: 'null'
    inputBinding:
      position: 101
      prefix: --LENGTH_TAG
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
  - id: mismatch_rate
    type:
      - 'null'
      - float
    doc: What fraction of bases the matched sequence can mismatch. Must be >=0 
      and <1. In contrast to MISMATCHES, this matcher will match the full 
      sequence even if it is preceded by something else in the read.
    default: 'null'
    inputBinding:
      position: 101
      prefix: --MISMATCH_RATE
  - id: mismatches
    type:
      - 'null'
      - int
    doc: How many mismatches are acceptable in the sequence. If neither 
      MISMATCHES nor MISMATCH_RATE is specified, default behavior is 
      MISMATCHES=0
    default: 'null'
    inputBinding:
      position: 101
      prefix: --MISMATCHES
  - id: num_bases
    type:
      - 'null'
      - int
    doc: How many bases at the beginning of the sequence must match before 
      trimming occurs.
    default: 0
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
  - id: sequence
    type: string
    doc: The sequence to look for at the start of reads.
    inputBinding:
      position: 101
      prefix: --SEQUENCE
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
    doc: The tag to set for trimmed reads. This tags the first base to keep in 
      the read. 6 would mean to trim the first 5 bases.
    default: ZS
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
