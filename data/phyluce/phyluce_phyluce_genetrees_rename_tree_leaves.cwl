cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_genetrees_rename_tree_leaves
label: phyluce_phyluce_genetrees_rename_tree_leaves
doc: "Rename the leaves of an input tree\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: input
    type: File
    doc: "The input tree file"
    inputBinding:
      position: 1
      prefix: --input
  - id: config
    type: File
    doc: "A python config file mapping one name to another"
    inputBinding:
      position: 2
      prefix: --config
  - id: output
    type: string
    doc: "The output tree file. The program requires that the file already exists, so an empty file of this name is created in the working directory before the run."
    inputBinding:
      position: 3
      prefix: --output
  - id: section
    type: string
    doc: "The section of the conf file to use"
    inputBinding:
      position: 4
      prefix: --section
  - id: order
    type:
      - 'null'
      - string
    doc: "Map the names as entered or in reverse. One of left:right, right:left."
    inputBinding:
      position: 5
      prefix: --order
  - id: input_format
    type:
      - 'null'
      - string
    doc: "The tree file format. One of nexus, newick, fasta, phylip."
    inputBinding:
      position: 6
      prefix: --input-format
  - id: output_format
    type:
      - 'null'
      - string
    doc: "The tree file format. One of nexus, newick, fasta, phylip."
    inputBinding:
      position: 7
      prefix: --output-format
  - id: reroot
    type:
      - 'null'
      - string
    doc: "The resulting name to root the tree on"
    inputBinding:
      position: 8
      prefix: --reroot
  - id: do_not_preserve_spaces
    type:
      - 'null'
      - string
    doc: "Do not retain spaces in output names"
    inputBinding:
      position: 9
      prefix: --do-not-preserve-spaces
outputs:
  - id: renamed_tree
    type: File
    doc: "The tree file with renamed leaves."
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "File", "basename": inputs.output, "contents": ""})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
