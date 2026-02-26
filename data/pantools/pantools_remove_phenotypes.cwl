cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - remove_phenotypes
label: pantools_remove_phenotypes
doc: "Delete phenotype nodes or remove specific phenotype information from the nodes.\n\
  \nTool homepage: https://git.wur.nl/bioinformatics/pantools"
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
  - id: phenotype
    type:
      - 'null'
      - string
    doc: Name of the phenotype.
    inputBinding:
      position: 102
      prefix: --phenotype
  - id: selection_file
    type:
      - 'null'
      - File
    doc: "Text file with rules to use a specific set of\ngnomes and sequences. This
      automatically lowers\nthe threshold for core genes."
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
stdout: pantools_remove_phenotypes.out
