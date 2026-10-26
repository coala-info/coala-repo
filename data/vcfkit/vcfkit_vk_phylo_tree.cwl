cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vk
  - phylo
  - tree
label: vcfkit_vk_phylo_tree
doc: "Build a dendrogram from a VCF by neighbour joining or UPGMA.\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
inputs:
  - id: method
    type: string
    doc: "Tree method: nj or upgma"
    inputBinding:
      position: 1
  - id: plot
    type:
      - 'null'
      - boolean
    doc: "Plot the tree"
    inputBinding:
      position: 2
      prefix: --plot
  - id: vcf
    type: File
    doc: "Input VCF or BCF file"
    inputBinding:
      position: 3
  - id: region
    type:
      - 'null'
      - string
    doc: "Restrict to this region, for example I:1-500000"
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit_vk_phylo_tree.out
