cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - add_antismash
label: pantools_add_antismash
doc: "Add antiSMASH gene clusters to the pangenome.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool changes it) and returned as the output.
    inputBinding:
      position: 1
  - id: antismash_file
    type: File
    doc: A text file with on each line a genome number and the file name of the corresponding
      antiSMASH output file (JSON), separated by a space.
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: antismash_output_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The antiSMASH output files named in the list file. They are staged in the
      working directory, so the list file can name them by file name.
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
      - entry: $(inputs.antismash_file)
        writable: true
      - $(inputs.antismash_output_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_add_antismash.log
