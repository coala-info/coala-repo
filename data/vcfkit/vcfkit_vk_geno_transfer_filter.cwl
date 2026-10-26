cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vk
  - geno
  - transfer-filter
label: vcfkit_vk_geno_transfer_filter
doc: "Transfer variant-level filters to genotypes.\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
inputs:
  - id: vcf
    type: File
    doc: "Input VCF or BCF file"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit_vk_geno_transfer_filter.out
