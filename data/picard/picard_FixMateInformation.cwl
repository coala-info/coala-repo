cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - FixMateInformation
label: picard_FixMateInformation
doc: Verify mate-pair information between mates and fix if needed. This tool 
  ensures that all mate-pair information is in sync between each read and its 
  mate pair. If no OUTPUT file is supplied then the output is written to a 
  temporary file and then copied over the INPUT file (with the original placed 
  in a .old file.) Reads marked with the secondary alignment flag are written to
  the output file unchanged. However supplementary reads are corrected so that 
  they point to the primary, non-supplemental mate record.
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: The SAM/BAM/CRAM input files to check and fix. Multiple files will be 
      merged and sorted. This argument must be specified at least once.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: add_mate_cigar
    type:
      - 'null'
      - boolean
    doc: Adds the mate CIGAR tag (MC) if true, does not if false.
    inputBinding:
      position: 101
      prefix: --ADD_MATE_CIGAR
  - id: arguments_file
    type:
      - 'null'
      - type: array
        items: File
    doc: read one or more arguments files and add them to the command line
    inputBinding:
      position: 101
      prefix: --arguments_file
  - id: assume_sorted
    type:
      - 'null'
      - boolean
    doc: If true, assume that the input file is queryname sorted, even if the 
      header says otherwise.
    inputBinding:
      position: 101
      prefix: --ASSUME_SORTED
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
  - id: ignore_missing_mates
    type:
      - 'null'
      - boolean
    doc: If true, ignore missing mates, otherwise will throw an exception when 
      missing mates are found.
    inputBinding:
      position: 101
      prefix: --IGNORE_MISSING_MATES
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
    inputBinding:
      position: 101
      prefix: --MAX_RECORDS_IN_RAM
  - id: output
    type: string
    doc: The output file to write to. If no output file is supplied, the input 
      file is overwritten (only available with single input file).
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
  - id: sort_order
    type:
      - 'null'
      - string
    doc: 'Optional sort order if the OUTPUT file should be sorted differently than
      the INPUT file. Possible values: {unsorted, queryname, coordinate, duplicate,
      unknown}'
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
    type:
      - 'null'
      - File
    doc: The output file to write to. If no output file is supplied, the input 
      file is overwritten (only available with single input file).
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
