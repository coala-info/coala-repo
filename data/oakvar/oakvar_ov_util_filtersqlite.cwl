cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ov
  - util
  - filtersqlite
label: oakvar_ov_util_filtersqlite
doc: "Filters SQLite result files to produce filtered SQLite result files.\n\nTool homepage: http://www.oakvar.com"
inputs:
  - id: dbpaths
    type:
      type: array
      items: File
    doc: Path to result database.
    inputBinding:
      position: 1
  - id: out
    type:
      - 'null'
      - string
    doc: Output SQLite file folder.
    inputBinding:
      position: 102
      prefix: -o
  - id: suffix
    type:
      - 'null'
      - string
    doc: Suffix for output SQLite files.
    inputBinding:
      position: 102
      prefix: -s
  - id: filterpath
    type:
      - 'null'
      - File
    doc: Path to a filter JSON file.
    inputBinding:
      position: 102
      prefix: -f
  - id: filtersql
    type:
      - 'null'
      - string
    doc: Filter SQL.
    inputBinding:
      position: 102
      prefix: --filtersql
  - id: includesample
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample IDs to include.
    inputBinding:
      position: 102
      prefix: --includesample
  - id: excludesample
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample IDs to exclude.
    inputBinding:
      position: 102
      prefix: --excludesample
outputs:
  - id: filtered_sqlite
    type:
      type: array
      items: File
    doc: Filtered SQLite result files.
    outputBinding:
      glob: '*.sqlite'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
stdout: oakvar_ov_util_filtersqlite.out
