cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - deactivate_grouping
label: pantools_deactivate_grouping
doc: "Deactivate the currently active homology grouping.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool changes it) and returned as the output.
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
stdout: pantools_deactivate_grouping.out
