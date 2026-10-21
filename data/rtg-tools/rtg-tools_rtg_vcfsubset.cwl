cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - vcfsubset
label: rtg-tools_rtg_vcfsubset
doc: 'Removes columnar data from VCF records. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
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
    doc: 'VCF file containing variants to manipulate'
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: 'output VCF file'
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
  - id: keep_filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --keep-filter
    doc: 'keep the specified FILTER tag. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: keep_format
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --keep-format
    doc: 'keep the specified FORMAT field. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: keep_info
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --keep-info
    doc: 'keep the specified INFO tag. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: keep_sample
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --keep-sample
    doc: 'file containing sample IDs to keep, or a literal sample name. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: remove_filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --remove-filter
    doc: 'remove the specified FILTER tag. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: remove_filters
    type:
      - 'null'
      - boolean
    doc: 'remove all FILTER tags'
    inputBinding:
      position: 101
      prefix: --remove-filters
  - id: remove_format
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --remove-format
    doc: 'remove the specified FORMAT field. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: remove_ids
    type:
      - 'null'
      - boolean
    doc: 'remove the contents of the ID field'
    inputBinding:
      position: 101
      prefix: --remove-ids
  - id: remove_info
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --remove-info
    doc: 'remove the specified INFO tag. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: remove_infos
    type:
      - 'null'
      - boolean
    doc: 'remove all INFO tags'
    inputBinding:
      position: 101
      prefix: --remove-infos
  - id: remove_qual
    type:
      - 'null'
      - boolean
    doc: 'remove the QUAL field'
    inputBinding:
      position: 101
      prefix: --remove-qual
  - id: remove_sample
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --remove-sample
    doc: 'file containing sample IDs to remove, or a literal sample name. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: remove_samples
    type:
      - 'null'
      - boolean
    doc: 'remove all samples'
    inputBinding:
      position: 101
      prefix: --remove-samples
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
    doc: 'Subset VCF and its index'
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_vcfsubset.out
