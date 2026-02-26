cwlVersion: v1.2
class: CommandLineTool
baseCommand: barcodeforge barcode
label: barcodeforge_barcode
doc: "Process barcode data, including VCF generation, tree formatting, USHER placement,
  matUtils annotation, and matUtils extraction.\n\nTool homepage: https://github.com/andersen-lab/BarcodeForge"
inputs:
  - id: reference_genome
    type: File
    doc: Reference genome file
    inputBinding:
      position: 1
  - id: alignment
    type: File
    doc: Alignment file
    inputBinding:
      position: 2
  - id: tree
    type: File
    doc: Tree file
    inputBinding:
      position: 3
  - id: lineages
    type: File
    doc: Lineages file
    inputBinding:
      position: 4
  - id: matutils_overlap
    type:
      - 'null'
      - float
    doc: Value for --set-overlap in matUtils annotate.
    default: 0.0
    inputBinding:
      position: 105
      prefix: --matutils-overlap
  - id: plot_chunk_size
    type:
      - 'null'
      - int
    doc: Number of mutations to render in each plot chunk. Use -1 for no 
      chunking.
    default: 100
    inputBinding:
      position: 105
      prefix: --plot-chunk-size
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to add to lineage names in the barcode file.
    default: ''
    inputBinding:
      position: 105
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs/threads to use.
    default: 8
    inputBinding:
      position: 105
      prefix: --threads
  - id: tree_format
    type:
      - 'null'
      - string
    doc: Specify the format of the tree file (newick or nexus)
    inputBinding:
      position: 105
      prefix: --tree-format
  - id: usher_args
    type:
      - 'null'
      - string
    doc: Additional arguments to pass to usher (e.g., '-U -l'). Quote multiple 
      arguments.
    inputBinding:
      position: 105
      prefix: --usher-args
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barcodeforge:1.1.2--pyhdfd78af_0
stdout: barcodeforge_barcode.out
