cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyluce_genetrees_order_gene_tree_file
label: phyluce_phyluce_genetrees_order_gene_tree_file
doc: "Root some genetrees\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: newick_treefile
    type: File
    doc: "A newick-formatted treefile to input"
    inputBinding:
      position: 1
      prefix: --newick-treefile
  - id: output
    type: string
    doc: "The output newick-formatted treefile to create"
    inputBinding:
      position: 2
      prefix: --output
  - id: root
    type: string
    doc: "The taxon on which to root trees"
    inputBinding:
      position: 3
      prefix: --root
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "The logging level to use. One of INFO, WARN, CRITICAL."
    inputBinding:
      position: 4
      prefix: --verbosity
  - id: log_path
    type:
      - 'null'
      - string
    doc: "The path to a directory to hold logs. The directory is created in the working directory before the run."
    inputBinding:
      position: 5
      prefix: --log-path
outputs:
  - id: log_dir
    type:
      - 'null'
      - Directory
    doc: "The directory that holds the logs."
    outputBinding:
      glob: "$(inputs.log_path)"
  - id: ordered_trees
    type: File
    doc: "The rerooted gene trees, one per line, sorted by number of taxa."
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$(inputs.log_path ? {"class": "Directory", "basename": inputs.log_path, "listing": []} : null)'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
