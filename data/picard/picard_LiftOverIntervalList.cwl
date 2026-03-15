cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - LiftOverIntervalList
label: picard_LiftOverIntervalList
doc: Lifts over an interval list from one reference build to another. This tool 
  adjusts the coordinates in an interval list on one reference to its homologous
  interval list on another reference, based on a chain file that describes the 
  correspondence between the two references.
inputs:
  - id: chain
    type: File
    doc: Chain file that guides the LiftOver process.
    inputBinding:
      position: 101
      prefix: --CHAIN
  - id: input
    type:
      - 'null'
      - File
    doc: The input interval list to be lifted over.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output
    type: string
    doc: The output interval list file.
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    doc: Sequence dictionary to place in the output interval list. (This should 
      be any file from which the dictionary of the target reference can be 
      extracted.)
    inputBinding:
      position: 101
      prefix: --SEQUENCE_DICTIONARY
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
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: min_liftover_pct
    type:
      - 'null'
      - float
    doc: Minimum percentage of bases in each input interval that must map to 
      output interval for liftover of that interval to occur.
    inputBinding:
      position: 101
      prefix: --MIN_LIFTOVER_PCT
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
  - id: reject
    type: string
    doc: Interval List file for intervals that were rejected
    inputBinding:
      position: 101
      prefix: --REJECT
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
    doc: 'Validation stringency for all SAM files read by this program. Possible values:
      {STRICT, LENIENT, SILENT}'
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
    doc: The output interval list file.
    outputBinding:
      glob: $(inputs.output)
  - id: output_reject
    type:
      - 'null'
      - File
    doc: Interval List file for intervals that were rejected
    outputBinding:
      glob: $(inputs.reject)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/picard:3.4.0--hdfd78af_0
s:url: http://broadinstitute.github.io/picard/
$namespaces:
  s: https://schema.org/
