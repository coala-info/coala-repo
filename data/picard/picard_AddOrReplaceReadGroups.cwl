cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - AddOrReplaceReadGroups
label: picard_AddOrReplaceReadGroups
doc: "Assigns all the reads in a file to a single new read-group.\n\nTool homepage:
  http://broadinstitute.github.io/picard/"
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
  - id: input
    type: File
    doc: Input file (BAM or SAM or a GA4GH url).
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
  - id: rgcn
    type:
      - 'null'
      - string
    doc: Read-Group sequencing center name
    inputBinding:
      position: 101
      prefix: --RGCN
  - id: rgds
    type:
      - 'null'
      - string
    doc: Read-Group description
    inputBinding:
      position: 101
      prefix: --RGDS
  - id: rgdt
    type:
      - 'null'
      - string
    doc: Read-Group run date
    inputBinding:
      position: 101
      prefix: --RGDT
  - id: rgfo
    type:
      - 'null'
      - string
    doc: Read-Group flow order
    inputBinding:
      position: 101
      prefix: --RGFO
  - id: rgid
    type:
      - 'null'
      - string
    doc: Read-Group ID
    default: '1'
    inputBinding:
      position: 101
      prefix: --RGID
  - id: rgks
    type:
      - 'null'
      - string
    doc: Read-Group key sequence
    inputBinding:
      position: 101
      prefix: --RGKS
  - id: rglb
    type: string
    doc: Read-Group library
    inputBinding:
      position: 101
      prefix: --RGLB
  - id: rgpg
    type:
      - 'null'
      - string
    doc: Read-Group program group
    inputBinding:
      position: 101
      prefix: --RGPG
  - id: rgpi
    type:
      - 'null'
      - int
    doc: Read-Group predicted insert size
    inputBinding:
      position: 101
      prefix: --RGPI
  - id: rgpl
    type: string
    doc: Read-Group platform (e.g. ILLUMINA, SOLID)
    inputBinding:
      position: 101
      prefix: --RGPL
  - id: rgpm
    type:
      - 'null'
      - string
    doc: Read-Group platform model
    inputBinding:
      position: 101
      prefix: --RGPM
  - id: rgpu
    type: string
    doc: Read-Group platform unit (eg. run barcode)
    inputBinding:
      position: 101
      prefix: --RGPU
  - id: rgsm
    type: string
    doc: Read-Group sample name
    inputBinding:
      position: 101
      prefix: --RGSM
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
    doc: Optional sort order to output in. If not supplied OUTPUT is in the same
      order as INPUT.
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
    doc: Validation stringency for all SAM files read by this program.
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
  - id: output
    type: File
    doc: Output file (SAM, BAM or CRAM).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
