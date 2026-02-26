cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vk
  - phylo
label: vcfkit_vk phylo
doc: "Phylogenetic analysis tools for VCF files.\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
inputs:
  - id: fasta_input
    type: File
    doc: Input VCF file for fasta subcommand
    inputBinding:
      position: 1
  - id: tree_method
    type: string
    doc: Tree building method (nj or upgma)
    inputBinding:
      position: 2
  - id: region
    type:
      - 'null'
      - string
    doc: Optional region to process
    inputBinding:
      position: 3
  - id: tree_input_vcf
    type: File
    doc: Input VCF file for tree subcommand
    inputBinding:
      position: 4
  - id: tree_region
    type:
      - 'null'
      - string
    doc: Optional region to process for tree subcommand
    inputBinding:
      position: 5
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Plot the resulting tree
    inputBinding:
      position: 106
      prefix: --plot
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit_vk phylo.out
