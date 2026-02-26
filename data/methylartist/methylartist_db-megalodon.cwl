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
    default: 0.8
    inputBinding:
      position: 101
      prefix: --minprob
  - id: motifsize
    type:
      - 'null'
      - int
    doc: mod motif size (default is 2 as "CG" is most common use case, e.g. set 
      to 1 for 6mA)
    default: 2
    inputBinding:
      position: 101
      prefix: --motifsize
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
