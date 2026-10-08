cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - root_phylogeny
label: pantools_root_phylogeny
doc: "(Re)root a phylogenetic tree.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool writes its results inside it) and returned as the output.
    inputBinding:
      position: 1
  - id: tree_file
    type: File
    doc: A phylogenetic tree in Newick format.
    inputBinding:
      position: 2
  - id: node
    type: string
    doc: The name of the terminal node that will root the tree.
    inputBinding:
      position: 102
      prefix: --node=
      separate: false
outputs:
  - id: database
    type: Directory
    doc: The pangenome database, with the results written inside it.
    outputBinding:
      glob: $(inputs.database_directory.basename)
  - id: reroot_script
    type: File
    doc: The R script (reroot.R, written in the database directory) that reroots the
      tree with the ape package.
    outputBinding:
      glob: $(inputs.database_directory.basename)/reroot.R
  - id: log
    type: stdout
    doc: Standard output (run log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database_directory)
        writable: true
      - entry: $(inputs.tree_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_root_phylogeny.log
