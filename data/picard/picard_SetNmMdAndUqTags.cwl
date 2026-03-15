cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - picard
  - SetNmMdAndUqTags
label: picard_SetNmMdAndUqTags
doc: This tool takes in a coordinate-sorted SAM/BAM/CRAM and calculates the NM, 
  MD, and UQ tags by comparing with the reference. This may be needed when 
  MergeBamAlignment was run with SORT_ORDER other than 'coordinate' and thus 
  could not fix these tags then. The input must be coordinate sorted in order to
  run. If specified, the MD and NM tags can be ignored and only the UQ tag be 
  set.
inputs:
  - id: input
    type: File
    doc: The SAM/BAM/CRAM file to fix.
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output
    type: string
    doc: The fixed SAM/BAM/CRAM output file.
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
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
  - id: is_bisulfite_sequence
    type:
      - 'null'
      - boolean
    doc: Whether the file contains bisulfite sequence (used when calculating the
      NM tag).
    inputBinding:
      position: 101
      prefix: --IS_BISULFITE_SEQUENCE
  - id: max_records_in_ram
    type:
      - 'null'
      - int
    doc: When writing files that need to be sorted, this will specify the number
      of records stored in RAM before spilling to disk.
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
  - id: set_only_uq
    type:
      - 'null'
      - boolean
    doc: Only set the UQ tag, ignore MD and NM.
    inputBinding:
      position: 101
      prefix: --SET_ONLY_UQ
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
    doc: Validation stringency for all SAM files read by this program. Setting 
      stringency to SILENT can improve performance when processing a BAM file in
      which variable-length data (read, qualities, tags) do not otherwise need 
      to be decoded.
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
    doc: The fixed SAM/BAM/CRAM output file.
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
