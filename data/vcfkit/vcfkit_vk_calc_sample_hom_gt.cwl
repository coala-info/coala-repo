cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vk
  - calc
  - sample_hom_gt
label: vcfkit_vk_calc_sample_hom_gt
doc: "Calculate the frequency of homozygous genotypes per sample.\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
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
stdout: vcfkit_vk_calc_sample_hom_gt.out
