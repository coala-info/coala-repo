cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- ReplaceSamHeader
label: gatk_ReplaceSamHeader
doc: |-
  Replaces the SAMFileHeader in a SAM/BAM/CRAM file. This tool makes it possible to replace the header of a SAM/BAM/CRAM file with the header of anotherfile, or a header block that has been edited manually (in a stub SAM file). The sort order (@SO) of the two input files must be the same. Note that validation is minimal, so it is up to the user to ensure that all the elements referred to in the SAMRecords are present in the new header.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: header
  type: File
  doc: SAM/BAM/CRAM file from which SAMFileHeader will be read.
  inputBinding:
    position: 101
    prefix: --HEADER
- id: input
  type: File
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  doc: SAM/BAM/CRAM file from which SAMRecords will be read.
  inputBinding:
    position: 101
    prefix: --INPUT
- id: output
  type: string
  doc: header from HEADER file will be written to this file, followed by records from INPUT file
  inputBinding:
    position: 101
    prefix: --OUTPUT
- id: arguments_file
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --arguments_file
  doc: read one or more arguments files and add them to the command line
  inputBinding:
    position: 101
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
  doc: Whether to create an index when writing VCF or coordinate sorted BAM output.
  inputBinding:
    position: 101
    prefix: --CREATE_INDEX
    valueFrom: '$(self === null ? null : String(self))'
- id: create_md5_file
  type:
  - 'null'
  - boolean
  doc: Whether to create an MD5 digest for any BAM or FASTQ files created.
  inputBinding:
    position: 101
    prefix: --CREATE_MD5_FILE
    valueFrom: '$(self === null ? null : String(self))'
- id: max_records_in_ram
  type:
  - 'null'
  - int
  doc: When writing files that need to be sorted, this will specify the number of records stored in RAM
    before spilling to disk. Increasing this number reduces the number of file handles needed to sort
    the file, and increases the amount of RAM needed.
  inputBinding:
    position: 101
    prefix: --MAX_RECORDS_IN_RAM
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Whether to suppress job-summary info on System.err.
  inputBinding:
    position: 101
    prefix: --QUIET
    valueFrom: '$(self === null ? null : String(self))'
- id: reference_sequence
  type:
  - 'null'
  - File
  secondaryFiles:
  - .fai
  - ^.dict
  doc: Reference sequence file.
  inputBinding:
    position: 101
    prefix: --REFERENCE_SEQUENCE
- id: tmp_dir
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --TMP_DIR
  doc: One or more directories with space available to be used by this program for temporary storage of
    working files
  inputBinding:
    position: 101
- id: use_jdk_deflater
  type:
  - 'null'
  - boolean
  doc: Use the JDK Deflater instead of the Intel Deflater for writing compressed output
  inputBinding:
    position: 101
    prefix: --USE_JDK_DEFLATER
    valueFrom: '$(self === null ? null : String(self))'
- id: use_jdk_inflater
  type:
  - 'null'
  - boolean
  doc: Use the JDK Inflater instead of the Intel Inflater for reading compressed input
  inputBinding:
    position: 101
    prefix: --USE_JDK_INFLATER
    valueFrom: '$(self === null ? null : String(self))'
- id: validation_stringency
  type:
  - 'null'
  - string
  doc: 'Validation stringency for all SAM files read by this program. Setting stringency to SILENT can
    improve performance when processing a BAM file in which variable-length data (read, qualities, tags)
    do not otherwise need to be decoded. Possible values: {STRICT, LENIENT, SILENT}'
  inputBinding:
    position: 101
    prefix: --VALIDATION_STRINGENCY
- id: verbosity
  type:
  - 'null'
  - string
  doc: 'Control verbosity of logging. Possible values: {ERROR, WARNING, INFO, DEBUG}'
  inputBinding:
    position: 101
    prefix: --VERBOSITY
- id: java_options
  type:
  - 'null'
  - string
  doc: Java options for the GATK launcher, for example -Xmx4g
  inputBinding:
    position: 101
    prefix: --java-options
outputs:
- id: output_output
  type: File
  doc: header from HEADER file will be written to this file, followed by records from INPUT file
  outputBinding:
    glob: $(inputs.output)
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  - pattern: .crai
    required: false
  - pattern: ^.crai
    required: false
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing: $([].concat(([{"entry":inputs.input,"writable":true}])))
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
