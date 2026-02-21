cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - FilterVcf
label: picard_FilterVcf
doc: "Applies one or more hard filters to a VCF file to filter out genotypes and variants.\n\
  \nTool homepage: http://broadinstitute.github.io/picard/"
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
    default: true
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
    doc: The INPUT VCF or BCF file.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: javascript_file
    type:
      - 'null'
      - File
    doc: Filters a VCF file with a javascript expression interpreted by the java
      javascript engine.
    inputBinding:
      position: 101
      prefix: --JAVASCRIPT_FILE
  - id: max_fs
    type:
      - 'null'
      - float
    doc: The maximum phred scaled fisher strand value before a site will be 
      filtered out.
    default: 1.7976931348623157e+308
    inputBinding:
      position: 101
      prefix: --MAX_FS
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
  - id: min_ab
    type:
      - 'null'
      - float
    doc: The minimum allele balance acceptable before filtering a site.
    default: 0.0
    inputBinding:
      position: 101
      prefix: --MIN_AB
  - id: min_dp
    type:
      - 'null'
      - int
    doc: The minimum sequencing depth supporting a genotype before the genotype 
      will be filtered out.
    default: 0
    inputBinding:
      position: 101
      prefix: --MIN_DP
  - id: min_gq
    type:
      - 'null'
      - int
    doc: The minimum genotype quality that must be achieved for a sample 
      otherwise the genotype will be filtered out.
    default: 0
    inputBinding:
      position: 101
      prefix: --MIN_GQ
  - id: min_qd
    type:
      - 'null'
      - float
    doc: The minimum QD value to accept or otherwise filter out the variant.
    default: 0.0
    inputBinding:
      position: 101
      prefix: --MIN_QD
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
    doc: The output VCF or BCF.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
