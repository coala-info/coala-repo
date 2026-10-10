cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylartist
  - db-megalodon
label: methylartist_db-megalodon
doc: "Process megalodon per_read_text methylation output into a database\n\nTool homepage:
  https://github.com/adamewing/methylartist"
inputs:
  - id: append
    type:
      - 'null'
      - boolean
    doc: append to database
    inputBinding:
      position: 101
      prefix: --append
  - id: methdata
    type: File
    doc: megalodon per_read_text methylation output
    inputBinding:
      position: 101
      prefix: --methdata
  - id: minprob
    type:
      - 'null'
      - float
    doc: probability threshold for calling modified or unmodified base
    inputBinding:
      position: 101
      prefix: --minprob
  - id: motifsize
    type:
      - 'null'
      - int
    doc: mod motif size (default is 2 as "CG" is most common use case, e.g. set 
      to 1 for 6mA)
    inputBinding:
      position: 101
      prefix: --motifsize
  - id: db_path
    type: string
    doc: 'database name (.db is appended when missing)'
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
    type:
      - 'null'
      - File
    doc: 'database name (.db is appended when missing)'
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
