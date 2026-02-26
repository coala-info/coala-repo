cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - snpreg
label: maq_snpreg
doc: "Call SNPs using consensus and SNP information.\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: input_cns
    type: File
    doc: Input consensus file (.cns)
    inputBinding:
      position: 1
  - id: input_snp
    type:
      - 'null'
      - File
    doc: Input SNP file (.snp)
    inputBinding:
      position: 2
  - id: max_read_depth
    type:
      - 'null'
      - int
    doc: maximum read depth
    default: 255
    inputBinding:
      position: 103
      prefix: -D
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    default: 40
    inputBinding:
      position: 103
      prefix: -Q
  - id: min_neighbouring_quality
    type:
      - 'null'
      - int
    doc: minimum neighbouring quality
    default: 20
    inputBinding:
      position: 103
      prefix: -n
  - id: min_read_depth
    type:
      - 'null'
      - int
    doc: minimum read depth
    default: 3
    inputBinding:
      position: 103
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_snpreg.out
