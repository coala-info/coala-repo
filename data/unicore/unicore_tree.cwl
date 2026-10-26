cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicore
  - tree
label: unicore_tree
doc: |-
  Infer phylogenetic tree from core structures

  Tool homepage: https://github.com/steineggerlab/unicore
inputs:
  - id: db
    type: File
    doc: "Input database (createdb output); the primary file is the database prefix file"
    secondaryFiles:
      - '.dbtype'
      - '.index'
      - '.lookup'
      - '.map'
      - '.source'
      - '_h'
      - '_h.dbtype'
      - '_h.index'
      - '_ss'
      - '_ss.dbtype'
      - '_ss.index'
    inputBinding:
      position: 1
  - id: input_dir
    type: Directory
    doc: "Input directory containing core structures (profile output)"
    inputBinding:
      position: 2
  - id: output_dir
    type: string
    doc: "Output directory"
    inputBinding:
      position: 3
  - id: aligner
    type: ['null', string]
    doc: "Multiple sequence aligner [foldmason, mafft-linsi, mafft] (default foldmason)"
    inputBinding:
      position: 10
      prefix: --aligner
  - id: tree_builder
    type: ['null', string]
    doc: "Phylogenetic tree builder [iqtree, fasttree, raxml-ng] (default iqtree)"
    inputBinding:
      position: 10
      prefix: --tree-builder
  - id: aligner_options
    type: ['null', string]
    doc: "Options for sequence aligner"
    inputBinding:
      position: 10
      prefix: --aligner-options
  - id: no_inference
    type: ['null', boolean]
    doc: "Stop the tree module after alignment (before tree inference)"
    inputBinding:
      position: 10
      prefix: --no-inference
  - id: tree_options
    type: ['null', string]
    doc: "Options for tree builder; if not given: iqtree: -m JTT+F+I+G -B 1000; fasttree: -gamma -boot 1000; raxml-ng: --model JTT+F+I+G --seed 12345 --all --tree pars{90},rand{10}"
    inputBinding:
      position: 10
      prefix: --tree-options
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
  - id: tree_directory
    type: Directory
    doc: Output directory with the alignment and the species tree
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
