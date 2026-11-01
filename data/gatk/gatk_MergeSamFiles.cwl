cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- MergeSamFiles
label: gatk_MergeSamFiles
doc: |-
  Merges multiple SAM/BAM/CRAM (and/or) files into a single file. This tool is used for combining SAM/BAM/CRAM (and/or) files from different runs or read groups into a single file, similarly to the "merge" function of Samtools (http://www.htslib.org/doc/samtools.html). Note that to prevent errors in downstream processing, it is critical to identify/label read groups appropriately. If different samples contain identical read group IDs, this tool will avoid collisions by modifying the read group IDs to be unique. For more information about read groups, see the GATK Dictionary entry.

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: input
  type:
    type: array
    items: File
    inputBinding:
      prefix: --INPUT
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  doc: SAM/BAM/CRAM input file
  inputBinding:
    position: 101
- id: output
  type: string
  doc: SAM/BAM/CRAM file to write merged result to
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
- id: assume_sorted
  type:
  - 'null'
  - boolean
  doc: If true, assume that the input files are in the same sort order as the requested output sort order,
    even if their headers say otherwise.
  inputBinding:
    position: 101
    prefix: --ASSUME_SORTED
    valueFrom: '$(self === null ? null : String(self))'
- id: comment
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --COMMENT
  doc: Comment(s) to include in the merged output file's header.
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
- id: intervals
  type:
  - 'null'
  - File
  doc: An interval list file that contains the locations of the positions to merge. Assume sam are sorted
    and indexed. The resulting file will contain alignments that may overlap with genomic regions outside
    the requested region. Unmapped reads are discarded.
  inputBinding:
    position: 101
    prefix: --INTERVALS
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
- id: merge_sequence_dictionaries
  type:
  - 'null'
  - boolean
  doc: Merge the sequence dictionaries
  inputBinding:
    position: 101
    prefix: --MERGE_SEQUENCE_DICTIONARIES
    valueFrom: '$(self === null ? null : String(self))'
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
- id: sort_order
  type:
  - 'null'
  - string
  doc: 'Sort order of output file Possible values: {unsorted, queryname, coordinate, duplicate, unknown}'
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
- id: use_threading
  type:
  - 'null'
  - boolean
  doc: Option to create a background thread to encode, compress and write to disk the output file. The
    threaded version uses about 20% more CPU and decreases runtime by ~20% when writing out a compressed
    BAM/CRAM file.
  inputBinding:
    position: 101
    prefix: --USE_THREADING
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
  doc: SAM/BAM/CRAM file to write merged result to
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
