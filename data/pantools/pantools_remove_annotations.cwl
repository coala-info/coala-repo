cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - remove_annotations
label: pantools_remove_annotations
doc: "Remove all the genomic features that belong to annotations.\n\nTool homepage:\
  \ https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool changes it) and returned as the output.
    inputBinding:
      position: 1
  - id: annotations_file
    type:
      - 'null'
      - File
    doc: A text file with the identifiers of annotations to be removed, each on a
      separate line.
    inputBinding:
      position: 102
      prefix: --annotations
  - id: exclude
    type:
      - 'null'
      - string
    doc: A selection of genomes excluded from the removal of annotations.
    inputBinding:
      position: 102
      prefix: -e=
      separate: false
  - id: include
    type:
      - 'null'
      - string
    doc: A selection of genomes for which all annotations will be removed.
    inputBinding:
      position: 102
      prefix: -i=
      separate: false
  - id: selection_file
    type:
      - 'null'
      - File
    doc: Text file with rules to use a specific set of genomes and sequences. This
      automatically lowers the threshold for core genes.
    inputBinding:
      position: 102
      prefix: --selection-file
  - id: confirmation
    type: File
    doc: 'Answer for the tool''s y/n confirmation prompt, read from standard input
      (default: a file containing ''y'').'
    default:
      class: File
      basename: confirmation.txt
      contents: "y\n"
outputs:
  - id: database
    type: Directory
    doc: The updated pangenome database
    outputBinding:
      glob: $(inputs.database_directory.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database_directory)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdin: $(inputs.confirmation.path)
stdout: pantools_remove_annotations.out
