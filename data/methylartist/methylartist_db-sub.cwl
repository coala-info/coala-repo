cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylartist
  - db-sub
label: methylartist_db-sub
doc: "Create a methylartist database from a bam file with substitution-based methylation calls (requires the MD tag), such as bisulfite alignments.\n\nTool homepage: https://github.com/adamewing/methylartist"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - .bai
    doc: bam file, requires MD tag
    inputBinding:
      position: 101
      prefix: --bam
  - id: append
    type:
      - 'null'
      - boolean
    doc: append to database
    inputBinding:
      position: 101
      prefix: --append
  - id: db_path
    type: string
    doc: database name (.db is appended when missing)
    inputBinding:
      position: 102
      prefix: --db
  - id: existing_db
    type:
      - 'null'
      - File
    doc: Existing database to extend when append is set; db_path must be its file name. Staged in the working directory.
outputs:
  - id: db
    type: File
    doc: database written by the tool
    outputBinding:
      glob: "$(inputs.db_path.endsWith('.db') ? inputs.db_path : inputs.db_path + '.db')"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${ return inputs.existing_db ? [{"entry": inputs.existing_db, "writable": true}] : []; }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
