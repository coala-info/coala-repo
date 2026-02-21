cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CreateSequenceDictionary
label: picard_CreateSequenceDictionary
doc: "Creates a sequence dictionary for a reference sequence. This tool creates a
  sequence dictionary file (with \".dict\" extension) from a reference sequence provided
  in FASTA format, which is required by many processing and analysis tools.\n\nTool
  homepage: http://broadinstitute.github.io/picard/"
inputs:
  - id: alt_names
    type:
      - 'null'
      - File
    doc: "Optional file containing the alternative names for the contigs. Tools may
      use this information to consider different contig notations as identical (e.g:
      'chr1' and '1')."
    inputBinding:
      position: 101
      prefix: --ALT_NAMES
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
  - id: genome_assembly
    type:
      - 'null'
      - string
    doc: Put into AS field of sequence dictionary entry if supplied
    inputBinding:
      position: 101
      prefix: --GENOME_ASSEMBLY
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
  - id: num_sequences
    type:
      - 'null'
      - int
    doc: Stop after writing this many sequences. For testing.
    default: 2147483647
    inputBinding:
      position: 101
      prefix: --NUM_SEQUENCES
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Whether to suppress job-summary info on System.err.
    default: false
    inputBinding:
      position: 101
      prefix: --QUIET
  - id: reference
    type: File
    doc: Input reference fasta or fasta.gz
    inputBinding:
      position: 101
      prefix: --REFERENCE
  - id: show_hidden
    type:
      - 'null'
      - boolean
    doc: display hidden arguments
    default: false
    inputBinding:
      position: 101
      prefix: --showHidden
  - id: species
    type:
      - 'null'
      - string
    doc: Put into SP field of sequence dictionary entry
    inputBinding:
      position: 101
      prefix: --SPECIES
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
  - id: truncate_names_at_whitespace
    type:
      - 'null'
      - boolean
    doc: Make sequence name the first word from the > line in the fasta file.
    default: true
    inputBinding:
      position: 101
      prefix: --TRUNCATE_NAMES_AT_WHITESPACE
  - id: uri
    type:
      - 'null'
      - string
    doc: Put into UR field of sequence dictionary entry. If not supplied, input 
      reference file is used
    inputBinding:
      position: 101
      prefix: --URI
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
    doc: Output SAM file containing only the sequence dictionary. By default it 
      will use the base name of the input reference with the .dict extension
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
