cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - rename_phylogeny
label: pantools_rename_phylogeny
doc: "Update or alter the terminal nodes (leaves) of a phylogenic tree.\n\nTool homepage:\
  \ https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool writes its results inside it) and returned as the output.
    inputBinding:
      position: 1
  - id: tree_file
    type: File
    doc: A phylogenetic tree.
    inputBinding:
      position: 2
  - id: gene_tree
    type:
      - 'null'
      - boolean
    doc: Tree labels are gene identifiers.
    inputBinding:
      position: 102
      prefix: --gene-tree
  - id: genome
    type:
      - 'null'
      - boolean
    doc: Tree labels are genome numbers.
    inputBinding:
      position: 102
      prefix: --genome
  - id: no_numbers
    type:
      - 'null'
      - boolean
    doc: Exclude genome numbers from the terminal nodes (leaves).
    inputBinding:
      position: 102
      prefix: --no-numbers
  - id: phenotype
    type:
      - 'null'
      - string
    doc: The phenotype used to rename the terminal nodes (leaves) of the selected
      tree.
    inputBinding:
      position: 102
      prefix: --phenotype=
      separate: false
  - id: phasing
    type:
      - 'null'
      - boolean
    doc: Analyse phased genomes.
    inputBinding:
      position: 102
      prefix: --phasing
  - id: sequence
    type:
      - 'null'
      - boolean
    doc: Tree labels are sequence identifiers.
    inputBinding:
      position: 102
      prefix: --sequence
outputs:
  - id: database
    type: Directory
    doc: The pangenome database, with the results written inside it.
    outputBinding:
      glob: $(inputs.database_directory.basename)
  - id: renamed_tree
    type: File
    doc: The tree with renamed terminal nodes (input file name with _RENAMED added
      before the extension).
    outputBinding:
      glob: $(inputs.tree_file.nameroot)_RENAMED*
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
stdout: pantools_rename_phylogeny.log
