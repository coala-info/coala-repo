cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbt
  - vcf-to-txt
label: rust-bio-tools_vcf-to-txt
doc: "Convert VCF/BCF file from STDIN to tab-separated TXT file at STDOUT. INFO and
  FORMAT tags have to be selected explicitly.\n\nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: fmt
    type:
      - 'null'
      - type: array
        items: string
    doc: Select FORMAT tags
    inputBinding:
      position: 101
      prefix: --fmt
  - id: genotypes
    type:
      - 'null'
      - boolean
    doc: Display genotypes
    inputBinding:
      position: 101
      prefix: --genotypes
  - id: info
    type:
      - 'null'
      - type: array
        items: string
    doc: Select INFO tags
    inputBinding:
      position: 101
      prefix: --info
  - id: with_filter
    type:
      - 'null'
      - boolean
    doc: Include FILTER field
    inputBinding:
      position: 101
      prefix: --with-filter
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
stdout: rust-bio-tools_vcf-to-txt.out
