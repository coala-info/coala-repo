cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- RevertSam
label: gatk_RevertSam
doc: |-
  Reverts SAM/BAM/CRAM files to a previous state. This tool removes or restores certain properties of the SAM records, including alignment information, which can be used to produce an unmapped BAM (uBAM) from a previously aligned BAM. It is also capable of restoring the original quality scores of a BAM file that has already undergone base quality score recalibration (BQSR) if theoriginal qualities were retained.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: input
  type: File
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  doc: The input SAM/BAM/CRAM file to revert the state of.
  inputBinding:
    position: 101
    prefix: --INPUT
- id: output
  type:
  - 'null'
  - string
  doc: The output SAM/BAM/CRAM file to create, or an output directory if OUTPUT_BY_READGROUP is true.
    Cannot be used in conjunction with argument(s) OUTPUT_MAP (OM)
  inputBinding:
    position: 101
    prefix: --OUTPUT
- id: output_map
  type:
  - 'null'
  - File
  doc: Tab separated file with two columns, READ_GROUP_ID and OUTPUT, providing file mapping only used
    if OUTPUT_BY_READGROUP is true. Cannot be used in conjunction with argument(s) OUTPUT (O)
  inputBinding:
    position: 101
    prefix: --OUTPUT_MAP
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
- id: attribute_to_clear
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --ATTRIBUTE_TO_CLEAR
  doc: When removing alignment information, the set of optional tags to remove.
  inputBinding:
    position: 101
- id: attribute_to_reverse
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --ATTRIBUTE_TO_REVERSE
  doc: Attributes on negative strand reads that need to be reversed.
  inputBinding:
    position: 101
- id: attribute_to_reverse_complement
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --ATTRIBUTE_TO_REVERSE_COMPLEMENT
  doc: Attributes on negative strand reads that need to be reverse complemented.
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
- id: keep_first_duplicate
  type:
  - 'null'
  - boolean
  doc: If SANITIZE=true keep the first record when we find more than one record with the same name for
    R1/R2/unpaired reads respectively. For paired end reads, keeps only the first R1 and R2 found respectively,
    and discards all unpaired reads. Duplicates do not refer to the duplicate flag in the FLAG field,
    but instead reads with the same name.
  inputBinding:
    position: 101
    prefix: --KEEP_FIRST_DUPLICATE
    valueFrom: '$(self === null ? null : String(self))'
- id: library_name
  type:
  - 'null'
  - string
  doc: The library name to use in the reverted output file. This will override the existing sample alias
    in the file and is used only if all the read groups in the input file have the same library name.
  inputBinding:
    position: 101
    prefix: --LIBRARY_NAME
- id: max_discard_fraction
  type:
  - 'null'
  - float
  doc: If SANITIZE=true and higher than MAX_DISCARD_FRACTION reads are discarded due to sanitization then
    the program will exit with an Exception instead of exiting cleanly. Output BAM will still be valid.
  inputBinding:
    position: 101
    prefix: --MAX_DISCARD_FRACTION
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
- id: output_by_readgroup
  type:
  - 'null'
  - boolean
  doc: When true, outputs each read group in a separate file.
  inputBinding:
    position: 101
    prefix: --OUTPUT_BY_READGROUP
    valueFrom: '$(self === null ? null : String(self))'
- id: output_by_readgroup_file_format
  type:
  - 'null'
  - string
  doc: When using OUTPUT_BY_READGROUP, the output file format can be set to a certain format.
  inputBinding:
    position: 101
    prefix: --OUTPUT_BY_READGROUP_FILE_FORMAT
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
- id: remove_alignment_information
  type:
  - 'null'
  - boolean
  doc: Remove all alignment information from the file.
  inputBinding:
    position: 101
    prefix: --REMOVE_ALIGNMENT_INFORMATION
    valueFrom: '$(self === null ? null : String(self))'
- id: remove_duplicate_information
  type:
  - 'null'
  - boolean
  doc: Remove duplicate read flags from all reads. Note that if this is false and REMOVE_ALIGNMENT_INFORMATION==true,
    the output may have the unusual but sometimes desirable trait of having unmapped reads that are marked
    as duplicates.
  inputBinding:
    position: 101
    prefix: --REMOVE_DUPLICATE_INFORMATION
    valueFrom: '$(self === null ? null : String(self))'
- id: restore_hardclips
  type:
  - 'null'
  - boolean
  doc: When true, restores reads and qualities of records with hard-clips containing XB and XQ tags.
  inputBinding:
    position: 101
    prefix: --RESTORE_HARDCLIPS
    valueFrom: '$(self === null ? null : String(self))'
- id: restore_original_qualities
  type:
  - 'null'
  - boolean
  doc: True to restore original qualities from the OQ field to the QUAL field if available.
  inputBinding:
    position: 101
    prefix: --RESTORE_ORIGINAL_QUALITIES
    valueFrom: '$(self === null ? null : String(self))'
- id: sample_alias
  type:
  - 'null'
  - string
  doc: The sample alias to use in the reverted output file. This will override the existing sample alias
    in the file and is used only if all the read groups in the input file have the same sample alias.
  inputBinding:
    position: 101
    prefix: --SAMPLE_ALIAS
- id: sanitize
  type:
  - 'null'
  - boolean
  doc: 'WARNING: This option is potentially destructive. If enabled will discard reads in order to produce
    a consistent output BAM. Reads discarded include (but are not limited to) paired reads with missing
    mates, duplicated records, records with mismatches in length of bases and qualities. This option can
    only be enabled if the output sort order is queryname and will always cause sorting to occur.'
  inputBinding:
    position: 101
    prefix: --SANITIZE
    valueFrom: '$(self === null ? null : String(self))'
- id: sort_order
  type:
  - 'null'
  - string
  doc: 'The sort order to create the reverted output file with. Possible values: {unsorted, queryname,
    coordinate, duplicate, unknown}'
  inputBinding:
    position: 101
    prefix: --SORT_ORDER
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
  type:
    type: array
    items: File
  doc: Reverted output file, or the files in the output directory when output by read group is set
  outputBinding:
    glob: '$(inputs.output ? (inputs.output_by_readgroup ? inputs.output + "/*" : inputs.output) : [])'
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing: '$([].concat(((inputs.output && inputs.output_by_readgroup) ? [{"entry":{"class":"Directory","listing":[]},"entryname":inputs.output,"writable":true}]
    : [])))'
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
