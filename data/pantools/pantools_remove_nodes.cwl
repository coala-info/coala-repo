cwlVersion: v1.2
class: CommandLineTool
baseCommand: pantools remove_nodes
label: pantools_remove_nodes
doc: "Remove a selection of nodes and their relationships from the pangenome.\n\n\
  Tool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory.
    inputBinding:
      position: 1
  - id: exclude
    type:
      - 'null'
      - string
    doc: Do not remove nodes of the selected genomes.
    inputBinding:
      position: 102
      prefix: --exclude
  - id: include
    type:
      - 'null'
      - string
    doc: Only remove nodes of the selected genomes.
    inputBinding:
      position: 102
      prefix: --include
  - id: label
    type:
      - 'null'
      - string
    doc: A node label.
    inputBinding:
      position: 102
      prefix: --label
  - id: nodes
    type:
      type: array
      items: string
    doc: One or multiple node identifiers, separated by a comma.
    inputBinding:
      position: 102
      prefix: --nodes
  - id: selection_file
    type:
      - 'null'
      - File
    doc: Text file with rules to use a specific set of genomes and sequences. 
      This automatically lowers the threshold for core genes.
    inputBinding:
      position: 102
      prefix: --selection-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_remove_nodes.out
