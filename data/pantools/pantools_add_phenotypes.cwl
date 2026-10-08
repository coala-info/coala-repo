cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - add_phenotypes
label: pantools_add_phenotypes
doc: "Add phenotype data to the pangenome.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool changes it) and returned as the output.
    inputBinding:
      position: 1
  - id: phenotypes_file
    type: File
    doc: A CSV file containing the phenotype information.
    inputBinding:
      position: 2
  - id: bins
    type:
      - 'null'
      - int
    doc: 'Number of bins used to group numerical values of a phenotype (default: 3).'
    inputBinding:
      position: 102
      prefix: --bins=
      separate: false
  - id: append
    type:
      - 'null'
      - boolean
    doc: Do not remove existing phenotype nodes but only add new properties to it.
    inputBinding:
      position: 102
      prefix: --append
outputs:
  - id: database
    type: Directory
    doc: The pangenome database, with the results written inside it.
    outputBinding:
      glob: $(inputs.database_directory.basename)
  - id: log
    type: stdout
    doc: Standard output (run log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database_directory)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_add_phenotypes.log
