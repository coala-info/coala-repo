cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vk
  - geno
  - het-polarization
label: vcfkit_vk_geno_het_polarization
doc: "Polarize heterozygous genotypes.\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
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
stdout: vcfkit_vk_geno_het_polarization.out
