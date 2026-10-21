cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - vcfannotate
label: rtg-tools_rtg_vcfannotate
doc: 'Adds annotations to a VCF file, either to the VCF ID field, or as a VCF INFO sub-field. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: bed_regions
    type:
      - 'null'
      - File
    doc: 'if set, only read VCF records that overlap the ranges contained in the specified BED file'
    inputBinding:
      position: 101
      prefix: --bed-regions
  - id: input
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: 'VCF file containing variants to annotate. Use ''-'' to read from standard input'
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: 'output VCF file name. Use ''-'' to write to standard output'
    inputBinding:
      position: 101
      prefix: --output
  - id: region
    type:
      - 'null'
      - string
    doc: 'if set, only read VCF records within the specified range. The format is one of <sequence_name>, <sequence_name>:<start>-<end>, <sequence_name>:<pos>+<length> or <sequence_name>:<pos>~<padding>'
    inputBinding:
      position: 101
      prefix: --region
  - id: annotation
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --annotation
    doc: 'add computed annotation to VCF records. Allowed values are [AC, AN, EP, GQD, IC, LAL, MEANQAD, NAA, PD, QA, QD, RA, SCONT, VAF, VAF1, ZY]. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: bed_ids
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --bed-ids
    doc: 'add variant IDs from BED file. May be specified 0 or more times'
    inputBinding:
      position: 101
  - id: bed_info
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --bed-info
    doc: 'add INFO annotations from BED file. May be specified 0 or more times'
    inputBinding:
      position: 101
  - id: fill_an_ac
    type:
      - 'null'
      - boolean
    doc: 'add or update the AN and AC INFO fields'
    inputBinding:
      position: 101
      prefix: --fill-an-ac
  - id: info_description
    type:
      - 'null'
      - string
    doc: 'if the BED INFO field is not already declared, use this description in the header (Default is Annotation)'
    inputBinding:
      position: 101
      prefix: --info-description
  - id: info_id
    type:
      - 'null'
      - string
    doc: 'the INFO ID for BED INFO annotations (Default is ANN)'
    inputBinding:
      position: 101
      prefix: --info-id
  - id: relabel
    type:
      - 'null'
      - File
    doc: 'relabel samples according to "old-name new-name" pairs in specified file'
    inputBinding:
      position: 101
      prefix: --relabel
  - id: vcf_ids
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --vcf-ids
    doc: 'add variant IDs from VCF file. May be specified 0 or more times'
    inputBinding:
      position: 101
  - id: add_header
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --add-header
    doc: 'file containing VCF header lines to add, or a literal header line. May be specified 0 or more times'
    inputBinding:
      position: 101
  - id: no_gzip
    type:
      - 'null'
      - boolean
    doc: 'do not gzip the output'
    inputBinding:
      position: 101
      prefix: --no-gzip
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: 'prevent VCF header from being written'
    inputBinding:
      position: 101
      prefix: --no-header
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: 'Annotated VCF and its index'
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_vcfannotate.out
