cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vk
  - calc
label: vcfkit_vk calc
doc: "Calculate various statistics from VCF files.\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to run (sample_hom_gt, genotypes, spectrum)
    inputBinding:
      position: 1
  - id: vcf_file
    type: File
    doc: Input VCF file
    inputBinding:
      position: 2
  - id: frequency
    type:
      - 'null'
      - boolean
    doc: Calculate allele frequencies
    inputBinding:
      position: 103
      prefix: --frequency
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit_vk calc.out
