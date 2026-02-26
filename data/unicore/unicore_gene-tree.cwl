cwlVersion: v1.2
class: CommandLineTool
baseCommand: unicore gene-tree
label: unicore_gene-tree
doc: "Infer phylogenetic tree of each core structures\n\nTool homepage: https://github.com/steineggerlab/unicore"
inputs:
  - id: input
    type: Directory
    doc: Input directory containing species phylogenetic tree (Output of the 
      Tree module)
    inputBinding:
      position: 1
  - id: aligner
    type:
      - 'null'
      - string
    doc: Multiple sequence aligner [foldmason, mafft-linsi, mafft]
    default: foldmason
    inputBinding:
      position: 102
      prefix: --aligner
  - id: aligner_options
    type:
      - 'null'
      - string
    doc: Options for sequence aligner
    inputBinding:
      position: 102
      prefix: --aligner-options
  - id: names
    type:
      - 'null'
      - File
    doc: File containing core structures for computing phylogenetic tree. If not
      provided, all core structures will be used
    default: ''
    inputBinding:
      position: 102
      prefix: --names
  - id: realign
    type:
      - 'null'
      - boolean
    doc: Compute the Multiple sequence alignment again. This will overwrite the 
      previous alignment
    inputBinding:
      position: 102
      prefix: --realign
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use; 0 to use all
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - int
    doc: Gap threshold for multiple sequence alignment [0 - 100]
    default: 50
    inputBinding:
      position: 102
      prefix: --threshold
  - id: tree_builder
    type:
      - 'null'
      - string
    doc: Phylogenetic tree builder [iqtree, fasttree, raxml-ng]
    default: iqtree
    inputBinding:
      position: 102
      prefix: --tree-builder
  - id: tree_options
    type:
      - 'null'
      - string
    doc: "Options for tree builder; If not given, following options will be applied:\n\
      iqtree:   -m JTT+F+I+G -B 1000\nfasttree: -gamma -boot 1000\nraxml-ng: --model
      JTT+F+I+G --seed 12345 --all --tree pars{90},rand{10}"
    inputBinding:
      position: 102
      prefix: --tree-options
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug)'
    default: 3
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
stdout: unicore_gene-tree.out
