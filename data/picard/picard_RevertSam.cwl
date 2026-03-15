cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - RevertSam
label: picard_RevertSam
doc: Reverts SAM/BAM/CRAM files to a previous state. This tool removes or 
  restores certain properties of the SAM records, including alignment 
  information, which can be used to produce an unmapped BAM (uBAM) from a 
  previously aligned BAM.
inputs:
  - id: input
    type: File
    doc: The input SAM/BAM/CRAM file to revert the state of.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output
    type: string
    doc: The output SAM/BAM/CRAM file to create, or an output directory if 
      OUTPUT_BY_READGROUP is true. Required unless OUTPUT_MAP is used.
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: output_map
    type: string
    doc: Tab separated file with two columns, READ_GROUP_ID and OUTPUT, 
      providing file mapping only used if OUTPUT_BY_READGROUP is true.
    inputBinding:
      position: 101
      prefix: --OUTPUT_MAP
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: attribute_to_clear
    type:
      - 'null'
      - type: array
        items: string
    doc: When removing alignment information, the set of optional tags to 
      remove.
    inputBinding:
      position: 101
      prefix: --ATTRIBUTE_TO_CLEAR
  - id: attribute_to_reverse
    type:
      - 'null'
      - type: array
        items: string
    doc: Attributes on negative strand reads that need to be reversed.
    inputBinding:
      position: 101
      prefix: --ATTRIBUTE_TO_REVERSE
  - id: attribute_to_reverse_complement
    type:
      - 'null'
      - type: array
        items: string
    doc: Attributes on negative strand reads that need to be reverse 
      complemented.
    inputBinding:
      position: 101
      prefix: --ATTRIBUTE_TO_REVERSE_COMPLEMENT
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
  - id: keep_first_duplicate
    type:
      - 'null'
      - boolean
    doc: If SANITIZE=true keep the first record when we find more than one 
      record with the same name for R1/R2/unpaired reads respectively.
    inputBinding:
      position: 101
      prefix: --KEEP_FIRST_DUPLICATE
  - id: library_name
    type:
      - 'null'
      - string
    doc: The library name to use in the reverted output file.
    inputBinding:
      position: 101
      prefix: --LIBRARY_NAME
  - id: max_discard_fraction
    type:
      - 'null'
      - float
    doc: If SANITIZE=true and higher than MAX_DISCARD_FRACTION reads are 
      discarded due to sanitization then the program will exit with an 
      Exception.
    inputBinding:
      position: 101
      prefix: --MAX_DISCARD_FRACTION
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
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
  - id: output_by_readgroup_file_format
    type:
      - 'null'
      - string
    doc: When using OUTPUT_BY_READGROUP, the output file format can be set to a 
      certain format (sam, bam, cram, dynamic).
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
  - id: reference_sequence
    type:
      - 'null'
      - File
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
  - id: remove_duplicate_information
    type:
      - 'null'
      - boolean
    doc: Remove duplicate read flags from all reads.
    inputBinding:
      position: 101
      prefix: --REMOVE_DUPLICATE_INFORMATION
  - id: restore_hardclips
    type:
      - 'null'
      - boolean
    doc: When true, restores reads and qualities of records with hard-clips 
      containing XB and XQ tags.
    inputBinding:
      position: 101
      prefix: --RESTORE_HARDCLIPS
  - id: restore_original_qualities
    type:
      - 'null'
      - boolean
    doc: True to restore original qualities from the OQ field to the QUAL field 
      if available.
    inputBinding:
      position: 101
      prefix: --RESTORE_ORIGINAL_QUALITIES
  - id: sample_alias
    type:
      - 'null'
      - string
    doc: The sample alias to use in the reverted output file.
    inputBinding:
      position: 101
      prefix: --SAMPLE_ALIAS
  - id: sanitize
    type:
      - 'null'
      - boolean
    doc: 'WARNING: This option is potentially destructive. If enabled will discard
      reads in order to produce a consistent output BAM.'
    inputBinding:
      position: 101
      prefix: --SANITIZE
  - id: sort_order
    type:
      - 'null'
      - string
    doc: The sort order to create the reverted output file with.
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
    type: File
    doc: The output SAM/BAM/CRAM file to create, or an output directory if 
      OUTPUT_BY_READGROUP is true. Required unless OUTPUT_MAP is used.
    outputBinding:
      glob: $(inputs.output)
  - id: output_output_map
    type: File
    doc: Tab separated file with two columns, READ_GROUP_ID and OUTPUT, 
      providing file mapping only used if OUTPUT_BY_READGROUP is true.
    outputBinding:
      glob: $(inputs.output_map)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
