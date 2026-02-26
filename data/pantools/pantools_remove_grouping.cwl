cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - remove_grouping
label: pantools_remove_grouping
doc: "Remove an homology grouping from the pangenome.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory.
    inputBinding:
      position: 1
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Do not remove is_similar relationships between mRNA nodes.
    inputBinding:
      position: 102
      prefix: --fast
  - id: grouping_version
    type: string
    doc: Specific grouping version to be removed. Must be a number, 'all' or 
      'all-inactive'.
    inputBinding:
      position: 102
      prefix: --grouping-version
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_remove_grouping.out
