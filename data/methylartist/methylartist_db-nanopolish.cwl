cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylartist
  - db-nanopolish
label: methylartist_db-nanopolish
doc: "Process nanopolish methylation output into a database\n\nTool homepage: https://github.com/adamewing/methylartist"
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
    type:
      type: array
      items: File
    doc: whole genome nanopolish methylation output, can be comma-delimited
    inputBinding:
      position: 101
      prefix: --methdata
      itemSeparator: ','
  - id: modname
    type:
      - 'null'
      - string
    doc: modification type (tag if combining multiple mods, default = "CpG")
    inputBinding:
      position: 101
      prefix: --modname
  - id: motif
    type:
      - 'null'
      - string
    doc: mod motif (default = CG)
    inputBinding:
      position: 101
      prefix: --motif
  - id: scalegroup
    type:
      - 'null'
      - boolean
    doc: scale threshold by number of CpGs in a group
    inputBinding:
      position: 101
      prefix: --scalegroup
  - id: thresh
    type:
      - 'null'
      - float
    doc: llr threshold (default = 2.5; if using --scalegroup the suggested 
      setting is 2.0)
    inputBinding:
      position: 101
      prefix: --thresh
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
