cwlVersion: v1.2
class: CommandLineTool
baseCommand: nopilesum
label: nopilesum
doc: "get pileup summaries\n\nTool homepage: https://github.com/blachlylab/nopilesum"
inputs:
  - id: in_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: in_vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: see even more info
    inputBinding:
      position: 103
      prefix: --debug
  - id: max_af
    type:
      - 'null'
      - float
    doc: VCF records with INFO/AF fields above this threshold won't be used
    default: 0.2
    inputBinding:
      position: 103
      prefix: --max-af
  - id: min_af
    type:
      - 'null'
      - float
    doc: VCF records with INFO/AF fields below this threshold won't be used
    default: 0.01
    inputBinding:
      position: 103
      prefix: --min-af
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: quiet warnings
    inputBinding:
      position: 103
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: see other info
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nopilesum:1.1.2--h5884fcd_0
stdout: nopilesum.out
