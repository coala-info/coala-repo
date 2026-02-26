cwlVersion: v1.2
class: CommandLineTool
baseCommand: locidex build
label: locidex_build
doc: "Build a locidex database\n\nTool homepage: https://pypi.org/project/locidex/"
inputs:
  - id: author
    type:
      - 'null'
      - string
    doc: Author Name for Locidex Database.
    default: root
    inputBinding:
      position: 101
      prefix: --author
  - id: db_desc
    type:
      - 'null'
      - string
    doc: Version code for locidex db
    inputBinding:
      position: 101
      prefix: --db_desc
  - id: db_ver
    type:
      - 'null'
      - string
    doc: 'Version code for locidex db: 1.0.0'
    inputBinding:
      position: 101
      prefix: --db_ver
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing directory
    inputBinding:
      position: 101
      prefix: --force
  - id: input_file
    type: File
    doc: Input tsv formated for locidex
    inputBinding:
      position: 101
      prefix: --input_file
  - id: name
    type: string
    doc: Database name
    inputBinding:
      position: 101
      prefix: --name
  - id: translation_table
    type:
      - 'null'
      - string
    doc: Translation table to use
    default: '11'
    inputBinding:
      position: 101
      prefix: --translation_table
outputs:
  - id: outdir
    type: Directory
    doc: Output directory to put results
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/locidex:0.4.0--pyhdfd78af_0
