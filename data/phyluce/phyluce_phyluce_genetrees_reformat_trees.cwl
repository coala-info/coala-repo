cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_genetrees_reformat_trees
label: phyluce_phyluce_genetrees_reformat_trees
doc: "Rename the leaves of an input tree\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: Directory
    doc: "The input trees directory"
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: string
    doc: "The output trees directory"
    inputBinding:
      position: 2
      prefix: --output
  - id: input_format
    type:
      - 'null'
      - string
    doc: "The tree file format. One of nexus, newick, fasta, phylip."
    inputBinding:
      position: 3
      prefix: --input-format
  - id: output_format
    type:
      - 'null'
      - string
    doc: "The tree file format. One of nexus, newick, fasta, phylip."
    inputBinding:
      position: 4
      prefix: --output-format
  - id: do_not_preserve_spaces
    type:
      - 'null'
      - string
    doc: "Do not retain spaces in output names"
    inputBinding:
      position: 5
      prefix: --do-not-preserve-spaces
outputs:
  - id: output_dir
    type: Directory
    doc: "The directory with the reformatted tree files."
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
