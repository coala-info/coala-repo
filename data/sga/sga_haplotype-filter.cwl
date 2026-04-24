cwlVersion: v1.2
class: CommandLineTool
baseCommand: sga_haplotype-filter
label: sga_haplotype-filter
doc: "Remove haplotypes and their associated variants from a data set.\n\nTool homepage:
  https://github.com/jts/sga"
inputs:
  - id: haplotype_file
    type: File
    doc: Haplotype file
    inputBinding:
      position: 1
  - id: vcf_file
    type: File
    doc: VCF file
    inputBinding:
      position: 2
  - id: haploid
    type:
      - 'null'
      - boolean
    doc: force use of the haploid model
    inputBinding:
      position: 103
      prefix: --haploid
  - id: reads
    type:
      - 'null'
      - File
    doc: load the FM-index of the reads in FILE
    inputBinding:
      position: 103
      prefix: --reads
  - id: reference
    type:
      - 'null'
      - string
    doc: load the reference genome from FILE
    inputBinding:
      position: 103
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: use NUM threads to compute the overlaps
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: out_prefix
    type:
      - 'null'
      - File
    doc: write the passed haplotypes and variants to STR.vcf and STR.fa
    outputBinding:
      glob: $(inputs.out_prefix)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
