cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicore
  - gene-tree
label: unicore_gene-tree
doc: |-
  Infer phylogenetic tree of each core structures

  Tool homepage: https://github.com/steineggerlab/unicore
inputs:
  - id: input
    type: Directory
    doc: "Input directory containing species phylogenetic tree (output of the tree module); gene trees are written into it"
    inputBinding:
      position: 1
  - id: names
    type: ['null', File]
    doc: "File containing core structures for computing phylogenetic tree. If not provided, all core structures will be used"
    inputBinding:
      position: 10
      prefix: --names
  - id: tree_builder
    type: ['null', string]
    doc: "Phylogenetic tree builder [iqtree, fasttree, raxml-ng] (default iqtree)"
    inputBinding:
      position: 10
      prefix: --tree-builder
  - id: tree_options
    type: ['null', string]
    doc: "Options for tree builder; if not given: iqtree: -m JTT+F+I+G -B 1000; fasttree: -gamma -boot 1000; raxml-ng: --model JTT+F+I+G --seed 12345 --all --tree pars{90},rand{10}"
    inputBinding:
      position: 10
      prefix: --tree-options
  - id: realign
    type: ['null', boolean]
    doc: "Compute the multiple sequence alignment again. This will overwrite the previous alignment"
    inputBinding:
      position: 10
      prefix: --realign
  - id: aligner
    type: ['null', string]
    doc: "Multiple sequence aligner [foldmason, mafft-linsi, mafft] (default foldmason)"
    inputBinding:
      position: 10
      prefix: --aligner
  - id: aligner_options
    type: ['null', string]
    doc: "Options for sequence aligner"
    inputBinding:
      position: 10
      prefix: --aligner-options
  - id: threshold
    type: ['null', int]
    doc: "Gap threshold for multiple sequence alignment [0 - 100] (default 50)"
    inputBinding:
      position: 10
      prefix: --threshold
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use; 0 to use all (default 0)"
    inputBinding:
      position: 10
      prefix: --threads
  - id: verbosity
    type: ['null', int]
    doc: "Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug) (default 3)"
    inputBinding:
      position: 10
      prefix: --verbosity
outputs:
  - id: gene_trees
    type: Directory
    doc: The input directory with the gene trees added
    outputBinding:
      glob: $(inputs.input.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
