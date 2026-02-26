cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rhocall
  - call
label: rhocall_call
doc: "Call runs of autozygosity. (deprecated: use bcftools roh instead.\n\nTool homepage:
  https://github.com/dnil/rhocall"
inputs:
  - id: vcf
    type: File
    doc: VCF file
    inputBinding:
      position: 1
  - id: block_constant
    type:
      - 'null'
      - int
    doc: Should be adapted to type of analysis(exome or genome)
    inputBinding:
      position: 102
      prefix: --block_constant
  - id: flag_upd_at_fraction
    type:
      - 'null'
      - float
    doc: Flag UPD if homozygous blocks span this fraction of total chr size
    inputBinding:
      position: 102
      prefix: --flag_upd_at_fraction
  - id: individual
    type:
      - 'null'
      - int
    doc: Index of individual in vcf/bcf, 0-based.
    inputBinding:
      position: 102
      prefix: --individual
  - id: max_het_fraction
    type:
      - 'null'
      - float
    doc: Max heterozygotes over homozygotes fraction in a homozygous block
    inputBinding:
      position: 102
      prefix: --max_het_fraction
  - id: max_hets
    type:
      - 'null'
      - float
    doc: Max heterozygotes per Mb in a homozygous block
    inputBinding:
      position: 102
      prefix: --max_hets
  - id: minimum_homs
    type:
      - 'null'
      - int
    doc: Minimum absolute number of homozygotes to report a block
    inputBinding:
      position: 102
      prefix: --minimum_homs
  - id: shortest_block
    type:
      - 'null'
      - int
    doc: Shortest block
    inputBinding:
      position: 102
      prefix: --shortest_block
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rhocall:0.5.1--py312h0fa9677_5
stdout: rhocall_call.out
