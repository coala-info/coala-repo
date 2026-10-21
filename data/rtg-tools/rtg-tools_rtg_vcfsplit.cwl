cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - vcfsplit
label: rtg-tools_rtg_vcfsplit
doc: 'Splits samples contained within a VCF into separate files, one per sample. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
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
    doc: 'the input VCF, or ''-'' to read from standard input'
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: 'directory for output'
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
  - id: keep_ref
    type:
      - 'null'
      - boolean
    doc: 'keep records where the sample is reference'
    inputBinding:
      position: 101
      prefix: --keep-ref
  - id: keep_sample
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --keep-sample
    doc: 'file containing sample IDs to select, or a literal sample name. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: remove_sample
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --remove-sample
    doc: 'file containing sample IDs to ignore, or a literal sample name. May be specified 0 or more times, or as a comma separated list'
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: 'Directory with one VCF per sample'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_vcfsplit.out
