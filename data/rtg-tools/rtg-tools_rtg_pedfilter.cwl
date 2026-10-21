cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rtg
  - pedfilter
label: rtg-tools_rtg_pedfilter
doc: 'Filter and convert a pedigree file. Tool homepage: https://github.com/RealTimeGenomics/rtg-tools'
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: keep_family
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --keep-family
    doc: 'keep only individuals with the specified family ID. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: keep_ids
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --keep-ids
    doc: 'keep only individuals with the specified ID. May be specified 0 or more times, or as a comma separated list'
    inputBinding:
      position: 101
  - id: keep_primary
    type:
      - 'null'
      - boolean
    doc: 'keep only primary individuals (those with a PED individual line / VCF sample column)'
    inputBinding:
      position: 101
      prefix: --keep-primary
  - id: remove_parentage
    type:
      - 'null'
      - boolean
    doc: 'remove all parent-child relationship information'
    inputBinding:
      position: 101
      prefix: --remove-parentage
  - id: vcf
    type:
      - 'null'
      - boolean
    doc: 'output pedigree in the form of a VCF header'
    inputBinding:
      position: 101
      prefix: --vcf
  - id: file
    type: File
    doc: 'the pedigree file to process, may be PED or VCF, use ''-'' to read from stdin'
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rtg-tools:3.13--hdfd78af_0
stdout: rtg-tools_rtg_pedfilter.out
