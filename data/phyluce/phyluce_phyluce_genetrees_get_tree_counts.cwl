cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_genetrees_get_tree_counts
label: phyluce_phyluce_genetrees_get_tree_counts
doc: "Count gene tree topologies\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: trees
    type: Directory
    doc: "Tree file"
    inputBinding:
      position: 1
      prefix: --trees
  - id: locus_support_output
    type: string
    doc: "The output file in which to store trees and their associated loci (config format)"
    inputBinding:
      position: 2
      prefix: --locus-support-output
  - id: schema
    type:
      - 'null'
      - string
    doc: "The scheme of the input data. One of nexus, newick, nexml, fasta, phylip."
    inputBinding:
      position: 3
      prefix: --schema
  - id: root
    type: string
    doc: "The taxon on which to root trees"
    inputBinding:
      position: 4
      prefix: --root
  - id: extension
    type: string
    doc: "File extension used with each 'best' tree"
    inputBinding:
      position: 5
      prefix: --extension
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: "Loci to exclude"
    inputBinding:
      position: 6
      prefix: --exclude
outputs:
  - id: tree_counts
    type: File
    doc: "Topology counts printed to standard output."
    outputBinding:
      glob: "tree_counts.txt"
  - id: locus_support
    type: File
    doc: "The trees and their associated loci in config format."
    outputBinding:
      glob: "$(inputs.locus_support_output)"
stdout: tree_counts.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
