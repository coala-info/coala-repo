cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - svdecompose
label: rtg-tools_rtg_svdecompose
doc: 'Split composite structural variants into a breakend representation. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: 'VCF file containing variants to filter. Use ''-'' to read from standard input'
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: 'output VCF file name. Use ''-'' to write to standard output'
    inputBinding:
      position: 101
      prefix: --output
  - id: min_indel_length
    type:
      - 'null'
      - int
    doc: 'minimum length for converting precise insertions and deletions to breakend (Default is 20)'
    inputBinding:
      position: 101
      prefix: --min-indel-length
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
    doc: 'Decomposed VCF and its index'
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_svdecompose.out
