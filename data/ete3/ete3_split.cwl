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
    inputBinding:
      position: 102
      prefix: --format
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Directory where the new tree files will be saved. Defaults to the 
      current directory.
    inputBinding:
      position: 102
      prefix: --output-dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for the output tree files. Defaults to 'tree'.
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
  - id: prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in prefix
    outputBinding:
      glob: $(inputs.prefix)*
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the new tree files will be saved. Defaults to the 
      current directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ete3:3.1.2
stdout: ete3_split.out
