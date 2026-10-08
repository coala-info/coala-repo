cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - grouping_overview
label: pantools_grouping_overview
doc: "Create an overview table for every homology grouping in the pangenome.\n\nTool\
  \ homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool writes its results inside it) and returned as the output.
    inputBinding:
      position: 1
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Only show which grouping is active and which groupings can be activated.
    inputBinding:
      position: 102
      prefix: --fast
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
stdout: pantools_grouping_overview.log
