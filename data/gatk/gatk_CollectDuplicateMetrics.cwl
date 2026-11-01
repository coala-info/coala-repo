cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - CollectDuplicateMetrics
label: gatk_CollectDuplicateMetrics
doc: 'Collect Duplicate metrics from marked file. This tool only collects the duplicate metrics from a
  file that has already been duplicate-marked. The resulting metrics file will always have a READ_PAIR_OPTICAL_DUPLICATES=0
  and as a result the ESTIMATED_LIBRARY_SIZE will be slightly incorrect.


  Tool homepage: https://www.broadinstitute.org/gatk/'
inputs:
  - id: input
    type: File
    doc: Input SAM/BAM/CRAM file.
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
  - id: metrics_file
    type: string
    doc: File to write duplication metrics to.
    inputBinding:
      position: 101
      prefix: --METRICS_FILE
  - id: assume_sorted
    type:
      - 'null'
      - boolean
    doc: 'If true (default), then the sort order in the header file will be ignored. Default value: true.
      Possible values: {true, false}'
    inputBinding:
      position: 101
      prefix: --ASSUME_SORTED
      valueFrom: $(String(self))
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
  - id: stop_after
    type:
      - 'null'
      - long
    doc: 'Stop after processing N reads, mainly for debugging. Default value: 0.'
    inputBinding:
      position: 101
      prefix: --STOP_AFTER
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
outputs:
  - id: metrics_file_out
    type: File
    doc: File to write duplication metrics to.
    outputBinding:
      glob: $(inputs.metrics_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
