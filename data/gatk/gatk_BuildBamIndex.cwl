cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - BuildBamIndex
label: gatk_BuildBamIndex
doc: 'Generates a BAM index ".bai" file. This tool creates an index file for the input BAM that allows
  fast look-up of data in a BAM file, lke an index on a database. Note that this tool cannot be run on
  SAM files, and that the input BAM file must be sorted in coordinate order.


  Tool homepage: https://www.broadinstitute.org/gatk/'
inputs:
  - id: input
    type: File
    doc: A BAM file or GA4GH URL to process. Must be sorted in coordinate order.
    inputBinding:
      position: 101
      prefix: --INPUT
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
  - id: output
    type:
      - 'null'
      - File
    doc: The BAM index file. Defaults to x.bai if INPUT is x.bam, otherwise INPUT.bai. If INPUT is a URL
      and OUTPUT is unspecified, defaults to a file in the current directory.
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
arguments:
  - prefix: --OUTPUT
    position: 101
    valueFrom: '$(inputs.output ? inputs.output : inputs.input.nameroot + ''.bai'')'
outputs:
  - id: output_out
    type: File
    doc: The BAM index file.
    outputBinding:
      glob: '$(inputs.output ? inputs.output : inputs.input.nameroot + ''.bai'')'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
