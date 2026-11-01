cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - AddCommentsToBam
label: gatk_AddCommentsToBam
doc: 'Adds comments to the header of a BAM file.This tool makes a copy of the input bam file, with a modified
  header that includes the comments specified at the command line (prefixed by @CO). Use double quotes
  to wrap comments that include whitespace or special characters. Note that this tool cannot be run on
  SAM files.


  Tool homepage: https://www.broadinstitute.org/gatk/'
inputs:
  - id: comment
    type:
      type: array
      items: string
      inputBinding:
        prefix: --COMMENT
    doc: Comments to add to the BAM file This argument must be specified at least once.
    inputBinding:
      position: 101
  - id: input
    type: File
    doc: Input BAM file to add a comment to the header
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
    doc: Output BAM file to write results
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
  - id: output_out
    type: File
    doc: Output BAM file to write results
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
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
