cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- SortSam
label: gatk_SortSam
doc: |-
  This tool sorts the input SAM or BAM file by coordinate, queryname (QNAME), or some other property of the SAM record. The SortOrder of a SAM/BAM/CRAM file is found in the SAM file header tag @HD in the field labeled SO. For a coordinate sorted SAM/BAM/CRAM file, read alignments are sorted first by the reference sequence name (RNAME) field using the reference sequence dictionary (@SQ tag). Alignments within these subgroups are secondarily sorted using the left-most mapping position of the read (POS). Subsequent to this sorting scheme, alignments are listed arbitrarily. For queryname-sorted alignments, the tool orders records deterministically by queryname field followed by record strand orientation flag, primary record flag, and secondary alignment flag. This ordering may change in future versions.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: input
  type: File
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  doc: The SAM, BAM or CRAM file to sort.
  inputBinding:
    position: 101
    prefix: --INPUT
- id: output
  type: string
  doc: The sorted SAM, BAM or CRAM output file.
  inputBinding:
    position: 101
    prefix: --OUTPUT
- id: sort_order
  type: string
  doc: Sort order of output file. queryname (Sorts according to the readname. This will place read-pairs
    and other derived reads (secondary and supplementary) adjacent to each other. Note that the readnames
    are compared lexicographically, even though they may include numbers. In paired reads, Read1 sorts
    before Read2.) coordinate (Sorts primarily according to the SEQ and POS fields of the record. The
    sequence will sorted according to the order in the sequence dictionary, taken from from the header
    of the file. Within each reference sequence, the reads are sorted by the position. Unmapped reads
    whose mates are mapped will be placed near their mates. Unmapped read-pairs are placed after all the
    mapped reads and their mates.) duplicate (Sorts the reads so that duplicates reads are adjacent. that
    the mate-cigar (MC) tag is present. The resulting will be sorted by library, unclipped 5-prime position,
    orientation, and mate's unclipped 5-prime position.)
  inputBinding:
    position: 101
    prefix: --SORT_ORDER
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
  doc: The sorted SAM, BAM or CRAM output file.
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
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
