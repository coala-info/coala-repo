cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - FilterSamReads
label: gatk_FilterSamReads
doc: 'Subsets reads from a SAM/BAM/CRAM file by applying one of several filters. Takes a SAM/BAM/CRAM
  file and subsets it by either excluding or only including certain reads such as aligned or unaligned
  reads, specific reads based on a list of reads names, an interval list, by Tag Values (type Z / String
  values only), or using a JavaScript script.


  Tool homepage: https://www.broadinstitute.org/gatk/'
inputs:
  - id: filter
    type: string
    doc: 'Which filter to use. Required. includeAligned (Output aligned reads only. INPUT SAM/BAM/CRAM
      must be in queryname SortOrder. (Note: first and second of paired reads must both be aligned to
      be included in OUTPUT.)) excludeAligned (Output Unmapped reads only. INPUT SAM/BAM/CRAM must be
      in queryname SortOrder. (Note: first and second of pair must both be aligned to be excluded from
      OUTPUT.)) includeReadList (Output reads with names contained in READ_LIST_FILE. See READ_LIST_FILE
      for more detail.) excludeReadList (Output reads with names *not* contained in READ_LIST_FILE. See
      READ_LIST_FILE for more detail.) includeJavascript (Output reads that have been accepted by the
      JAVASCRIPT_FILE script, that is, reads for which the value of the script is true. See the JAVASCRIPT_FILE
      argument for more detail. ) includePairedIntervals (Output reads that overlap with an interval from
      INTERVAL_LIST (and their mate). INPUT must be coordinate sorted.) includeTagValues (Output reads
      that have a value of tag TAG that is contained in the values for TAG_VALUES) excludeTagValues (Output
      reads that do not have a value of tag TAG that is contained in the values for TAG_VALUES)'
    inputBinding:
      position: 101
      prefix: --FILTER
  - id: input
    type: File
    doc: The SAM/BAM/CRAM file that will be filtered.
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
    inputBinding:
      position: 101
      prefix: --INPUT
  - id: output
    type: string
    doc: SAM/BAM/CRAM file for resulting reads.
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: create_index
    type:
      - 'null'
      - boolean
    doc: 'Whether to create an index when writing VCF or coordinate sorted BAM output. Default value:
      false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --CREATE_INDEX
      valueFrom: $(String(self))
  - id: create_md5_file
    type:
      - 'null'
      - boolean
    doc: 'Whether to create an MD5 digest for any BAM or FASTQ files created. Default value: false. Possible
      values: {true, false}'
    inputBinding:
      position: 101
      prefix: --CREATE_MD5_FILE
      valueFrom: $(String(self))
  - id: interval_list
    type:
      - 'null'
      - File
    doc: Interval List File containing intervals that will be included in the OUTPUT when using FILTER=includePairedIntervals
    inputBinding:
      position: 101
      prefix: --INTERVAL_LIST
  - id: javascript_file
    type:
      - 'null'
      - File
    doc: 'Filters the INPUT with a javascript expression using the java javascript-engine, when using
      FILTER=includeJavascript. The script puts the following variables in the script context: ''record''
      a SamRecord ( https://samtools.github.io/htsjdk/javadoc/htsjdk/htsjdk/samtools/SAMRecord.html )
      and ''header'' a SAMFileHeader ( https://samtools.github.io/htsjdk/javadoc/htsjdk/htsjdk/samtools/SAMFileHeader.html
      ). all the public members of SamRecord and SAMFileHeader are accessible. A record is accepted if
      the last value of the script evaluates to true.'
    inputBinding:
      position: 101
      prefix: --JAVASCRIPT_FILE
  - id: read_list_file
    type:
      - 'null'
      - File
    doc: File containing reads that will be included in or excluded from the OUTPUT SAM/BAM/CRAM file,
      when using FILTER=includeReadList or FILTER=excludeReadList.
    inputBinding:
      position: 101
      prefix: --READ_LIST_FILE
  - id: reference_sequence
    type:
      - 'null'
      - File
    doc: Reference sequence file.
    secondaryFiles:
      - .fai
      - ^.dict
    inputBinding:
      position: 101
      prefix: --REFERENCE_SEQUENCE
  - id: sort_order
    type:
      - 'null'
      - string
    doc: 'SortOrder of the OUTPUT file, otherwise use the SortOrder of the INPUT file. Possible values:
      {unsorted, queryname, coordinate, duplicate, unknown}'
    inputBinding:
      position: 101
      prefix: --SORT_ORDER
  - id: tag
    type:
      - 'null'
      - string
    doc: The tag to select from input SAM/BAM
    inputBinding:
      position: 101
      prefix: --TAG
  - id: tag_value
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --TAG_VALUE
    doc: The tag value(s) to filter by This argument may be specified 0 or more times.
    inputBinding:
      position: 101
  - id: validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for all SAM files read by this program. Setting stringency to SILENT can
      improve performance when processing a BAM file in which variable-length data (read, qualities, tags)
      do not otherwise need to be decoded. Default value: STRICT. Possible values: {STRICT, LENIENT, SILENT}'
    inputBinding:
      position: 101
      prefix: --VALIDATION_STRINGENCY
  - id: write_reads_files
    type:
      - 'null'
      - boolean
    doc: 'Create <OUTPUT>.reads file containing names of reads from INPUT and OUTPUT (for debugging purposes.)
      Default value: false. Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --WRITE_READS_FILES
      valueFrom: $(String(self))
outputs:
  - id: output_out
    type: File
    doc: SAM/BAM/CRAM file for resulting reads.
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
      - pattern: .sbi
        required: false
      - pattern: .md5
        required: false
  - id: output_reads_file
    type:
      - 'null'
      - File
    doc: Names of the reads written to OUTPUT (when WRITE_READS_FILES is true).
    outputBinding:
      glob: $(inputs.output.replace(/\.[^.]*$/, '')).reads
  - id: input_reads_file
    type:
      - 'null'
      - File
    doc: Names of the reads read from INPUT (when WRITE_READS_FILES is true).
    outputBinding:
      glob: $(inputs.input.nameroot).reads
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
