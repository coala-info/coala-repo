cwlVersion: v1.2
class: CommandLineTool
baseCommand: python
label: bird_tool_utils_python
doc: "Python interpreter for executing scripts, modules, or commands.\n\nTool homepage:
  https://github.com/wwood/bird_tool_utils-python"
inputs:
  - id: script_file
    type:
      - 'null'
      - File
    doc: program read from script file
    inputBinding:
      position: 1
  - id: script_args
    type:
      - 'null'
      - type: array
        items: string
    doc: arguments passed to program in sys.argv[1:]
    inputBinding:
      position: 2
  - id: check_hash_based_pycs
    type:
      - 'null'
      - string
    doc: control how Python invalidates hash-based .pyc files (always|default|never)
    inputBinding:
      position: 103
      prefix: --check-hash-based-pycs
  - id: command
    type:
      - 'null'
      - string
    doc: program passed in as string (terminates option list)
    inputBinding:
      position: 103
      prefix: -c
  - id: debug
    type:
      - 'null'
      - boolean
    doc: turn on parser debugging output (for experts only, only works on debug builds)
    inputBinding:
      position: 103
      prefix: -d
  - id: dont_write_bytecode
    type:
      - 'null'
      - boolean
    doc: don't write .pyc files on import
    inputBinding:
      position: 103
      prefix: -B
  - id: ignore_environment
    type:
      - 'null'
      - boolean
    doc: ignore PYTHON* environment variables (such as PYTHONPATH)
    inputBinding:
      position: 103
      prefix: -E
  - id: inspect_interactively
    type:
      - 'null'
      - boolean
    doc: inspect interactively after running script; forces a prompt even if stdin
      does not appear to be a terminal
    inputBinding:
      position: 103
      prefix: -i
  - id: isolate
    type:
      - 'null'
      - boolean
    doc: isolate Python from the user's environment (implies -E, -P and -s)
    inputBinding:
      position: 103
      prefix: -I
  - id: issue_warnings
    type:
      - 'null'
      - boolean
    doc: 'issue warnings about converting bytes/bytearray to str and comparing bytes/bytearray
      with str or bytes with int. (-bb: issue errors)'
    inputBinding:
      position: 103
      prefix: -b
  - id: module
    type:
      - 'null'
      - string
    doc: run library module as a script (terminates option list)
    inputBinding:
      position: 103
      prefix: -m
  - id: no_site_import
    type:
      - 'null'
      - boolean
    doc: don't imply 'import site' on initialization
    inputBinding:
      position: 103
      prefix: -S
  - id: no_user_site
    type:
      - 'null'
      - boolean
    doc: don't add user site directory to sys.path
    inputBinding:
      position: 103
      prefix: -s
  - id: optimize
    type:
      - 'null'
      - boolean
    doc: remove assert and __debug__-dependent statements; add .opt-1 before .pyc
      extension
    inputBinding:
      position: 103
      prefix: -O
  - id: optimize_more
    type:
      - 'null'
      - boolean
    doc: do -O changes and also discard docstrings; add .opt-2 before .pyc extension
    inputBinding:
      position: 103
      prefix: -OO
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: don't print version and copyright messages on interactive startup
    inputBinding:
      position: 103
      prefix: -q
  - id: safe_path
    type:
      - 'null'
      - boolean
    doc: don't prepend a potentially unsafe path to sys.path
    inputBinding:
      position: 103
      prefix: -P
  - id: skip_first_line
    type:
      - 'null'
      - boolean
    doc: 'skip first line of source, allowing use of non-Unix forms of #!cmd'
    inputBinding:
      position: 103
      prefix: -x
  - id: unbuffered
    type:
      - 'null'
      - boolean
    doc: force the stdout and stderr streams to be unbuffered
    inputBinding:
      position: 103
      prefix: -u
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: verbose (trace import statements); can be supplied multiple times to increase
      verbosity
    inputBinding:
      position: 103
      prefix: -v
  - id: warning_control
    type:
      - 'null'
      - string
    doc: warning control; arg is action:message:category:module:lineno
    inputBinding:
      position: 103
      prefix: -W
  - id: x_option
    type:
      - 'null'
      - string
    doc: set implementation-specific option
    inputBinding:
      position: 103
      prefix: -X
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bird_tool_utils_python:0.6.0--pyh7e72e81_0
stdout: bird_tool_utils_python.out
