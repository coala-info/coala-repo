cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - add_functions
label: pantools_add_functions
doc: "Add functional annotations to the pangenome.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool changes it) and returned as the output.
    inputBinding:
      position: 1
  - id: functions_file
    type: File
    doc: A text file with on each line a genome number and the file name of the corresponding
      functional annotation file, separated by a space.
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: function_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The functional annotation files named in the list file. They are staged in
      the working directory, so the list file can name them by file name.
  - id: annotations_file
    type:
      - 'null'
      - File
    doc: A text file with the identifiers of annotations to be included, each on a
      separate line.
    inputBinding:
      position: 102
      prefix: --annotations-file=
      separate: false
  - id: function
    type:
      - 'null'
      - string
    doc: Only add a specific functional annotation.
    inputBinding:
      position: 102
      prefix: --function=
      separate: false
  - id: functional_databases_directory
    type:
      - 'null'
      - Directory
    doc: 'Directory containing the functional annotation databases (go-basic.obo,
      gene_ontology.txt, Pfam-A.clans.tsv, interpro.xml and the TIGRFAM files). It
      is staged writable, because the tool adds combined files to it. Any missing
      databases would be downloaded (default: functional_databases in the pangenome
      database directory).'
    inputBinding:
      position: 102
      prefix: --functional-databases-directory=
      separate: false
      valueFrom: $(self.basename)
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
      - entry: $(inputs.functions_file)
        writable: true
      - $(inputs.function_files)
      - entry: $(inputs.functional_databases_directory)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_add_functions.log
