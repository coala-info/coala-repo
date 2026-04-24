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
outputs:
  - id: db
    type:
      - 'null'
      - File
    doc: 'database name (default: auto-infer)'
    outputBinding:
      glob: $(inputs.db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
