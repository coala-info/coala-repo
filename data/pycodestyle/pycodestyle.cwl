cwlVersion: v1.2
class: CommandLineTool
baseCommand: pep8
label: pycodestyle
doc: "Check code against the style conventions in PEP 8.\n\nTool homepage: https://github.com/PyCQA/pycodestyle"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Files or directories to check
    inputBinding:
      position: 1
  - id: benchmark
    type:
      - 'null'
      - boolean
    doc: measure processing speed
    inputBinding:
      position: 102
      prefix: --benchmark
  - id: config
    type:
      - 'null'
      - File
    doc: user config file location
    inputBinding:
      position: 102
      prefix: --config
  - id: count
    type:
      - 'null'
      - boolean
    doc: print total number of errors and warnings to standard error and set 
      exit code to 1 if total is not null
    inputBinding:
      position: 102
      prefix: --count
  - id: diff
    type:
      - 'null'
      - boolean
    doc: report changes only within line number ranges in the unified diff 
      received on STDIN
    inputBinding:
      position: 102
      prefix: --diff
  - id: exclude
    type:
      - 'null'
      - string
    doc: exclude files or directories which match these comma separated patterns
    inputBinding:
      position: 102
      prefix: --exclude
  - id: filename
    type:
      - 'null'
      - string
    doc: when parsing directories, only check filenames matching these comma 
      separated patterns
    inputBinding:
      position: 102
      prefix: --filename
  - id: first
    type:
      - 'null'
      - boolean
    doc: show first occurrence of each error
    inputBinding:
      position: 102
      prefix: --first
  - id: format
    type:
      - 'null'
      - string
    doc: set the error format [default|pylint|<custom>]
    inputBinding:
      position: 102
      prefix: --format
  - id: hang_closing
    type:
      - 'null'
      - boolean
    doc: hang closing bracket instead of matching indentation of opening 
      bracket's line
    inputBinding:
      position: 102
      prefix: --hang-closing
  - id: ignore
    type:
      - 'null'
      - string
    doc: skip errors and warnings (e.g. E4,W)
    inputBinding:
      position: 102
      prefix: --ignore
  - id: max_line_length
    type:
      - 'null'
      - int
    doc: set maximum allowed line length
    inputBinding:
      position: 102
      prefix: --max-line-length
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: report only file names, or nothing with -qq
    inputBinding:
      position: 102
      prefix: --quiet
  - id: repeat
    type:
      - 'null'
      - boolean
    doc: (obsolete) show all occurrences of the same error
    inputBinding:
      position: 102
      prefix: --repeat
  - id: select
    type:
      - 'null'
      - string
    doc: select errors and warnings (e.g. E,W6)
    inputBinding:
      position: 102
      prefix: --select
  - id: show_pep8
    type:
      - 'null'
      - boolean
    doc: show text of PEP 8 for each error (implies --first)
    inputBinding:
      position: 102
      prefix: --show-pep8
  - id: show_source
    type:
      - 'null'
      - boolean
    doc: show source code for each error
    inputBinding:
      position: 102
      prefix: --show-source
  - id: statistics
    type:
      - 'null'
      - boolean
    doc: count errors and warnings
    inputBinding:
      position: 102
      prefix: --statistics
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print status messages, or debug with -vv
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycodestyle:2.0.0--py35_0
stdout: pycodestyle.out
