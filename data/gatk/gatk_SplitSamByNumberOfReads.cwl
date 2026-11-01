cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- SplitSamByNumberOfReads
label: gatk_SplitSamByNumberOfReads
doc: |-
  Splits a SAM/BAM/CRAM file to multiple files.This tool splits the input query-grouped SAM/BAM/CRAM file into multiple files while maintaining the sort order. This can be used to split a large unmapped input in order to parallelize alignment. It will traverse the input twice unless TOTAL_READS_IN_INPUT is provided. Output type (and extension) will agreewith that of the input.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: input
  type: File
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  doc: Input SAM/BAM/CRAM file to split
  inputBinding:
    position: 101
    prefix: --INPUT
- id: output
  type: string
  doc: Directory in which to output the split BAM files.
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
- id: out_prefix
  type:
  - 'null'
  - string
  doc: Output files will be named <OUT_PREFIX>_N.EXT, where N enumerates the output file and EXT is the
    same as that of the input.
  inputBinding:
    position: 101
    prefix: --OUT_PREFIX
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
- id: split_to_n_files
  type:
  - 'null'
  - int
  doc: Split to N files.
  inputBinding:
    position: 101
    prefix: --SPLIT_TO_N_FILES
- id: split_to_n_reads
  type:
  - 'null'
  - int
  doc: Split to have approximately N reads per output file. The actual number of reads per output file
    will vary by no more than the number of output files * (the maximum number of reads with the same
    queryname - 1).
  inputBinding:
    position: 101
    prefix: --SPLIT_TO_N_READS
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
- id: total_reads_in_input
  type:
  - 'null'
  - long
  doc: Total number of reads in the input file. If this is not provided, the input will be read twice,
    the first time to get a count of the total reads.
  inputBinding:
    position: 101
    prefix: --TOTAL_READS_IN_INPUT
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
  type:
    type: array
    items: File
  doc: Directory in which to output the split BAM files (files written into the directory)
  outputBinding:
    glob: '$(inputs.output ? inputs.output + "/*" : [])'
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing: $([].concat(({"entry":{"class":"Directory","listing":[]},"entryname":inputs.output,"writable":true})))
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
