cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - CreateExtendedIlluminaManifest
label: picard_CreateExtendedIlluminaManifest
doc: "CreateExtendedIlluminaManifest takes an Illumina manifest file (this is the
  text version of an Illumina '.bpm' file) and creates an 'extended' version of this
  text file by adding fields that facilitate VCF generation by downstream tools. As
  part of generating this extended version of the manifest, the tool may mark loci
  as 'FAIL' if they do not pass validation.\n\nTool homepage: http://broadinstitute.github.io/picard/"
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
  - id: cluster_file
    type:
      - 'null'
      - File
    doc: The Standard (Hapmap-trained) cluster file (.egt) from Illumina. If 
      there are duplicate assays at a site, this is used to decide which is the 
      'best' by choosing the assay with the best GenTrain scores)
    inputBinding:
      position: 101
      prefix: --CLUSTER_FILE
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
  - id: dbsnp_file
    type:
      - 'null'
      - File
    doc: Reference dbSNP file in VCF format.
    inputBinding:
      position: 101
      prefix: --DBSNP_FILE
  - id: flag_duplicates
    type:
      - 'null'
      - boolean
    doc: Flag duplicates in the extended manifest. If this is set and there are 
      multiple passing assays at the same site then all but one will be marked 
      with the 'DUPE' flag.
    default: true
    inputBinding:
      position: 101
      prefix: --FLAG_DUPLICATES
  - id: input
    type: File
    doc: This is the text version of the Illumina .bpm file
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
    type: File
    doc: The reference sequence (fasta) for the TARGET genome build.
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
  - id: supported_build
    type:
      - 'null'
      - type: array
        items: string
    doc: A supported build. This is the name of the build as specified in the 
      'GenomeBuild' column of the Illumina manifest file.
    inputBinding:
      position: 101
      prefix: --SUPPORTED_BUILD
  - id: supported_chain_file
    type:
      - 'null'
      - type: array
        items: File
    doc: A chain file that maps from SUPPORTED_BUILD -> TARGET_BUILD.
    inputBinding:
      position: 101
      prefix: --SUPPORTED_CHAIN_FILE
  - id: supported_reference_file
    type:
      - 'null'
      - type: array
        items: File
    doc: A reference file for the provided SUPPORTED_BUILD.
    inputBinding:
      position: 101
      prefix: --SUPPORTED_REFERENCE_FILE
  - id: target_build
    type:
      - 'null'
      - string
    doc: The target build. This specifies the reference for which the extended 
      manifest will be generated.
    default: '37'
    inputBinding:
      position: 101
      prefix: --TARGET_BUILD
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
    doc: The name of the extended manifest to be written.
    outputBinding:
      glob: $(inputs.output)
  - id: report_file
    type: File
    doc: The name of the the report file
    outputBinding:
      glob: $(inputs.report_file)
  - id: bad_assays_file
    type:
      - 'null'
      - File
    doc: The name of the the 'bad assays file'. This is a subset version of the 
      extended manifest, containing only unmappable assays
    outputBinding:
      glob: $(inputs.bad_assays_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
