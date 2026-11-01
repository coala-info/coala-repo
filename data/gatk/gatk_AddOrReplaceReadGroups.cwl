cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - AddOrReplaceReadGroups
label: gatk_AddOrReplaceReadGroups
doc: 'Assigns all the reads in a file to a single new read-group. This tool accepts INPUT BAM and SAM
  files or URLs from the Global Alliance for Genomics and Health (GA4GH) .


  Tool homepage: https://www.broadinstitute.org/gatk/'
inputs:
  - id: input
    type: File
    doc: Input file (BAM or SAM or a GA4GH url).
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
    doc: Output file (SAM, BAM or CRAM).
    inputBinding:
      position: 101
      prefix: --OUTPUT
  - id: rglb
    type: string
    doc: Read-Group library
    inputBinding:
      position: 101
      prefix: --RGLB
  - id: rgpl
    type: string
    doc: Read-Group platform (e.g. ILLUMINA, SOLID)
    inputBinding:
      position: 101
      prefix: --RGPL
  - id: rgpu
    type: string
    doc: Read-Group platform unit (eg. run barcode)
    inputBinding:
      position: 101
      prefix: --RGPU
  - id: rgsm
    type: string
    doc: Read-Group sample name
    inputBinding:
      position: 101
      prefix: --RGSM
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
  - id: rgcn
    type:
      - 'null'
      - string
    doc: Read-Group sequencing center name
    inputBinding:
      position: 101
      prefix: --RGCN
  - id: rgds
    type:
      - 'null'
      - string
    doc: Read-Group description
    inputBinding:
      position: 101
      prefix: --RGDS
  - id: rgdt
    type:
      - 'null'
      - string
    doc: Read-Group run date
    inputBinding:
      position: 101
      prefix: --RGDT
  - id: rgfo
    type:
      - 'null'
      - string
    doc: Read-Group flow order
    inputBinding:
      position: 101
      prefix: --RGFO
  - id: rgid
    type:
      - 'null'
      - string
    doc: 'Read-Group ID Default value: 1.'
    inputBinding:
      position: 101
      prefix: --RGID
  - id: rgks
    type:
      - 'null'
      - string
    doc: Read-Group key sequence
    inputBinding:
      position: 101
      prefix: --RGKS
  - id: rgpg
    type:
      - 'null'
      - string
    doc: Read-Group program group
    inputBinding:
      position: 101
      prefix: --RGPG
  - id: rgpi
    type:
      - 'null'
      - int
    doc: Read-Group predicted insert size
    inputBinding:
      position: 101
      prefix: --RGPI
  - id: rgpm
    type:
      - 'null'
      - string
    doc: Read-Group platform model
    inputBinding:
      position: 101
      prefix: --RGPM
  - id: sort_order
    type:
      - 'null'
      - string
    doc: 'Optional sort order to output in. If not supplied OUTPUT is in the same order as INPUT. Possible
      values: {unsorted, queryname, coordinate, duplicate, unknown}'
    inputBinding:
      position: 101
      prefix: --SORT_ORDER
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
    doc: Output file (SAM, BAM or CRAM).
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
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
