cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - rename_matrix
label: pantools_rename_matrix
doc: "Rename the headers (first row and leftmost column) of CSV formatted matrix files.\n\
  \nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool writes its results inside it) and returned as the output.
    inputBinding:
      position: 1
  - id: matrix_file
    type: File
    doc: A matrix file with numerical values.
    inputBinding:
      position: 2
  - id: selection_file
    type:
      - 'null'
      - File
    doc: Text file with rules to use a specific set of genomes and sequences. This
      automatically lowers the threshold for core genes.
    inputBinding:
      position: 102
      prefix: --selection-file=
      separate: false
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude a selection of genomes (for example 3,4).
    inputBinding:
      position: 102
      prefix: --exclude=
      separate: false
  - id: include
    type:
      - 'null'
      - string
    doc: Only include a selection of genomes (for example 1,2).
    inputBinding:
      position: 102
      prefix: --include=
      separate: false
  - id: phenotype
    type:
      - 'null'
      - string
    doc: A phenotype name, used to include phenotype information into the headers.
    inputBinding:
      position: 102
      prefix: --phenotype=
      separate: false
  - id: numbers
    type:
      - 'null'
      - boolean
    doc: Include genome numbers in the headers (the default).
    inputBinding:
      position: 102
      prefix: --numbers
  - id: no_numbers
    type:
      - 'null'
      - boolean
    doc: Exclude genome numbers from the headers.
    inputBinding:
      position: 102
      prefix: --no-numbers
outputs:
  - id: database
    type: Directory
    doc: The pangenome database, with the results written inside it.
    outputBinding:
      glob: $(inputs.database_directory.basename)
  - id: renamed_matrix
    type: File
    doc: The matrix with renamed headers (input file name plus _RENAMED).
    outputBinding:
      glob: $(inputs.matrix_file.basename)_RENAMED
  - id: log
    type: stdout
    doc: Standard output (run log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database_directory)
        writable: true
      - entry: $(inputs.matrix_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_rename_matrix.log
