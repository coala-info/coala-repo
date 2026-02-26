cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vk
  - vcf2tsv
label: vcfkit_vk vcf2tsv
doc: "Convert VCF to TSV format\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
inputs:
  - id: format
    type: string
    doc: 'Output format: wide or long'
    inputBinding:
      position: 1
  - id: vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 2
  - id: ann
    type:
      - 'null'
      - boolean
    doc: Include ANN field
    inputBinding:
      position: 103
      prefix: --ANN
  - id: print_header
    type:
      - 'null'
      - boolean
    doc: Print header
    inputBinding:
      position: 103
      prefix: --print-header
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit_vk vcf2tsv.out
