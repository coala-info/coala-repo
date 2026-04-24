cwlVersion: v1.2
class: CommandLineTool
baseCommand: datamash
label: datamash_last
doc: "Performs numeric/string operations on input from stdin.\n\nTool homepage: https://github.com/agordon/datamash"
inputs:
  - id: operation
    type: string
    doc: The operation to perform. If a primary operation is used, it must be 
      listed first, optionally followed by other operations.
    inputBinding:
      position: 1
  - id: field
    type:
      - 'null'
      - type: array
        items: string
    doc: The input field to use. Can be a number (1=first field), or a field 
      name when using the -H or --header-in options. Multiple fields can be 
      listed with a comma (e.g. 1,6,8). A range of fields can be listed with a 
      dash (e.g. 2-8). Use colons for operations which require a pair of fields 
      (e.g. 'pcov 2:6').
    inputBinding:
      position: 2
  - id: collapse_delimiter
    type:
      - 'null'
      - string
    doc: 'use X to separate elements in collapse and unique lists (default: comma)'
    inputBinding:
      position: 103
      prefix: --collapse-delimiter
  - id: field_separator
    type:
      - 'null'
      - string
    doc: use X instead of TAB as field delimiter
    inputBinding:
      position: 103
      prefix: --field-separator
  - id: filler
    type:
      - 'null'
      - string
    doc: fill missing values with X (default N/A)
    inputBinding:
      position: 103
      prefix: --filler
  - id: format
    type:
      - 'null'
      - string
    doc: print numeric values with printf style floating-point FORMAT.
    inputBinding:
      position: 103
      prefix: --format
  - id: full
    type:
      - 'null'
      - boolean
    doc: 'print entire input line before op results (default: print only the grouped
      keys). This option is only sensible for linewise operations. Other uses are
      deprecated and will be removed in a future version of GNU Datamash.'
    inputBinding:
      position: 103
      prefix: --full
  - id: group
    type:
      - 'null'
      - string
    doc: group via fields X,[Y,Z]; equivalent to primary operation 'groupby'
    inputBinding:
      position: 103
      prefix: --group
  - id: header_in
    type:
      - 'null'
      - boolean
    doc: first input line is column headers
    inputBinding:
      position: 103
      prefix: --header-in
  - id: header_out
    type:
      - 'null'
      - boolean
    doc: print column headers as first line
    inputBinding:
      position: 103
      prefix: --header-out
  - id: headers
    type:
      - 'null'
      - boolean
    doc: same as '--header-in --header-out'
    inputBinding:
      position: 103
      prefix: --headers
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: ignore upper/lower case when comparing text; this affects grouping, and
      string operations
    inputBinding:
      position: 103
      prefix: --ignore-case
  - id: narm
    type:
      - 'null'
      - boolean
    doc: skip NA/NaN values
    inputBinding:
      position: 103
      prefix: --narm
  - id: no_strict
    type:
      - 'null'
      - boolean
    doc: allow lines with varying number of fields
    inputBinding:
      position: 103
      prefix: --no-strict
  - id: output_delimiter
    type:
      - 'null'
      - string
    doc: 'use X instead as output field delimiter (default: use same delimiter as
      -t/-W)'
    inputBinding:
      position: 103
      prefix: --output-delimiter
  - id: round
    type:
      - 'null'
      - int
    doc: round numeric output to N decimal places
    inputBinding:
      position: 103
      prefix: --round
  - id: seed
    type:
      - 'null'
      - string
    doc: set a seed for operations that use randomization
    inputBinding:
      position: 103
      prefix: --seed
  - id: skip_comments
    type:
      - 'null'
      - boolean
    doc: skip comment lines (starting with '#' or ';' and optional whitespace)
    inputBinding:
      position: 103
      prefix: --skip-comments
  - id: sort
    type:
      - 'null'
      - boolean
    doc: sort the input before grouping; this removes the need to manually pipe 
      the input through 'sort'
    inputBinding:
      position: 103
      prefix: --sort
  - id: sort_cmd
    type:
      - 'null'
      - File
    doc: Alternative sort(1) to use.
    inputBinding:
      position: 103
      prefix: --sort-cmd
  - id: vnlog
    type:
      - 'null'
      - boolean
    doc: Reads and writes data in the vnlog format. Implies -C -H -W
    inputBinding:
      position: 103
      prefix: --vnlog
  - id: whitespace
    type:
      - 'null'
      - boolean
    doc: use whitespace (one or more spaces and/or tabs) for field delimiters
    inputBinding:
      position: 103
      prefix: --whitespace
  - id: zero_terminated
    type:
      - 'null'
      - boolean
    doc: end lines with 0 byte, not newline
    inputBinding:
      position: 103
      prefix: --zero-terminated
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datamash:1.9
stdout: datamash_last.out
