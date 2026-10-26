cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vk
  - phylo
  - fasta
label: vcfkit_vk_phylo_fasta
doc: "Write a multi-sample FASTA of the variant sites in a VCF.\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
inputs:
  - id: vcf
    type: File
    doc: "Input VCF or BCF file"
    inputBinding:
      position: 1
  - id: region
    type:
      - 'null'
      - string
    doc: "Restrict to this region, for example I:1-500000"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit_vk_phylo_fasta.out
