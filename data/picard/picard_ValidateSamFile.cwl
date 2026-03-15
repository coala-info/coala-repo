cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - ValidateSamFile
label: picard_ValidateSamFile
doc: Validates a SAM/BAM/CRAM file relative to the SAM format specification. 
  Reports on troubleshooting errors like improper formatting, faulty alignments,
  incorrect flag values, etc.
inputs:
  - id: input
    type: File
    doc: Input SAM/BAM/CRAM file
    inputBinding:
      position: 101
      prefix: --INPUT
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
  - id: ignore
    type:
      - 'null'
      - type: array
        items: string
    doc: List of validation error types to ignore.
    inputBinding:
      position: 101
      prefix: --IGNORE
  - id: ignore_warnings
    type:
      - 'null'
      - boolean
    doc: If true, only report errors and ignore warnings.
    inputBinding:
      position: 101
      prefix: --IGNORE_WARNINGS
  - id: index_validation_stringency
    type:
      - 'null'
      - string
    doc: If set to anything other than IndexValidationStringency.NONE and input 
      is a BAM file with an index file, also validates the index at the 
      specified stringency.
    inputBinding:
      position: 101
      prefix: --INDEX_VALIDATION_STRINGENCY
  - id: is_bisulfite_sequenced
    type:
      - 'null'
      - boolean
    doc: Whether the input file consists of bisulfite sequenced reads.
    inputBinding:
      position: 101
      prefix: --IS_BISULFITE_SEQUENCED
  - id: max_open_temp_files
    type:
      - 'null'
      - int
    doc: Maximum number of file handles to keep open when spilling mate info to 
      disk.
    inputBinding:
      position: 101
      prefix: --MAX_OPEN_TEMP_FILES
  - id: max_output
    type:
      - 'null'
      - int
    doc: The maximum number of lines output in verbose mode
    inputBinding:
      position: 101
      prefix: --MAX_OUTPUT
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: mode
    type:
      - 'null'
      - string
    doc: Mode of output
    inputBinding:
      position: 101
      prefix: --MODE
  - id: output
    type: string
    doc: Output file or standard out if missing
    inputBinding:
      position: 101
      prefix: --OUTPUT
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
  - id: skip_mate_validation
    type:
      - 'null'
      - boolean
    doc: If true, this tool will not attempt to validate mate information.
    inputBinding:
      position: 101
      prefix: --SKIP_MATE_VALIDATION
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
  - id: validate_index
    type:
      - 'null'
      - boolean
    doc: DEPRECATED. Use INDEX_VALIDATION_STRINGENCY instead. If true and input 
      is a BAM file with an index file, also validates the index.
    inputBinding:
      position: 101
      prefix: --VALIDATE_INDEX
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: Validation stringency for all SAM files read by this program.
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
    type:
      - 'null'
      - File
    doc: Output file or standard out if missing
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
