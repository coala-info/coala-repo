cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vk
  - calc
  - genotypes
label: vcfkit_vk_calc_genotypes
doc: "Calculate genotype counts and frequencies per site.\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
inputs:
  - id: frequency
    type:
      - 'null'
      - boolean
    doc: "Report frequencies"
    inputBinding:
      position: 1
      prefix: --frequency
  - id: vcf
    type: File
    doc: "Input VCF or BCF file"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit_vk_calc_genotypes.out
