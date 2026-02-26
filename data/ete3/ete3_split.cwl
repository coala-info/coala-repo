cwlVersion: v1.2
class: CommandLineTool
baseCommand: ete3_split
label: ete3_split
doc: "Splits a tree file into several smaller tree files, one for each tree in the
  original file.\n\nTool homepage: http://etetoolkit.org/"
inputs:
  - id: tree_file
    type: File
    doc: The tree file to split.
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: "Format of the output trees. Supported formats: newick, nexus, phyloxml,
      tnt. Defaults to 'newick'."
    default: newick
    inputBinding:
      position: 102
      prefix: --format
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the new tree files will be saved. Defaults to the 
      current directory.
    default: .
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for the output tree files. Defaults to 'tree'.
    default: tree
    inputBinding:
      position: 102
      prefix: --prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress output messages.
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ete3:3.1.2
stdout: ete3_split.out
