cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metacache
  - info
label: metacache_info
doc: "Show database and reference sequence properties stored in a MetaCache database.\n\nTool homepage: https://github.com/muellan/metacache"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.database_files)
inputs:
  - id: database
    type: 
      - 'null'
      - string
    doc: "Database name (omit to show properties of the MetaCache executable)"
    inputBinding:
      position: 1
  - id: database_files
    type:
      type: array
      items: File
    doc: "Database files (<database>.meta and <database>.cache0, .cache1, ...) staged in the working directory"
  - id: sub_mode
    type: 
      - 'null'
      - string
    doc: "reference | rank | lineages | statistics | locations | featurecounts"
    inputBinding:
      position: 2
  - id: sub_mode_args
    type:
      - 'null'
      - type: array
        items: string
    doc: "Sequence ids for 'reference' or the rank name for 'rank'"
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
stdout: metacache_info.out
