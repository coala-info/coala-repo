cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - show_go
label: pantools_show_go
doc: "For a given GO term, show the child terms, all parent terms higher in the hierarchy,\
  \ and connected mRNA nodes.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool writes its results inside it) and returned as the output.
    inputBinding:
      position: 1
  - id: functions
    type:
      - 'null'
      - string
    doc: One or multiple GO term identifiers, separated by a comma.
    inputBinding:
      position: 102
      prefix: --functions=
      separate: false
  - id: nodes
    type:
      - 'null'
      - string
    doc: One or multiple identifiers of 'GO' nodes, separated by a comma.
    inputBinding:
      position: 102
      prefix: --nodes=
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_show_go.log
