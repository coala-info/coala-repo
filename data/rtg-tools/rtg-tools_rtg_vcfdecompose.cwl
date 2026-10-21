cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - vcfdecompose
label: rtg-tools_rtg_vcfdecompose
doc: 'Decomposes complex variants within a VCF file into smaller components. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: 'VCF file containing variants to decompose. Use ''-'' to read from standard input'
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: 'output VCF file name. Use ''-'' to write to standard output'
    inputBinding:
      position: 101
      prefix: --output
  - id: template
    type:
      - 'null'
      - Directory
    doc: 'SDF of the reference genome the variants are called against'
    inputBinding:
      position: 101
      prefix: --template
  - id: break_indels
    type:
      - 'null'
      - boolean
    doc: 'if set, peel as many SNPs off an indel as possible'
    inputBinding:
      position: 101
      prefix: --break-indels
  - id: break_mnps
    type:
      - 'null'
      - boolean
    doc: 'if set, break MNPs into individual SNPs'
    inputBinding:
      position: 101
      prefix: --break-mnps
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
stdout: rtg-tools_rtg_vcfdecompose.out
