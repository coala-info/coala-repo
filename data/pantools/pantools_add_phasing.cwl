cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - add_phasing
label: pantools_add_phasing
doc: "Add phasing information to the pangenome.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool changes it) and returned as the output.
    inputBinding:
      position: 1
  - id: phasing_file
    type: File
    doc: 'A text file with phasing information of sequences: two columns separated
      by a tab, space or comma, with a sequence identifier and a chromosome number
      or phasing identifier.'
    inputBinding:
      position: 2
  - id: assume_unphased
    type:
      - 'null'
      - boolean
    doc: All chromosomes without a letter will be be considered unphased.
    inputBinding:
      position: 102
      prefix: --assume-unphased
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
stdout: pantools_add_phasing.log
