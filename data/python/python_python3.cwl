cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3
label: python_python3
doc: "Execute Python scripts or modules.\n\nTool homepage: https://github.com/vinta/awesome-python"
inputs:
  - id: file
    type:
      - 'null'
      - File
    doc: program read from script file
    inputBinding:
      position: 1
  - id: stdin_input
    type:
      - 'null'
      - string
    doc: program read from stdin (default; interactive mode if a tty)
    inputBinding:
      position: 2
  - id: program_args
    type:
      - 'null'
      - type: array
        items: string
    doc: arguments passed to program in sys.argv[1:]
    inputBinding:
      position: 3
  - id: check_hash_based_pycs
    type:
      - 'null'
      - string
    doc: control how Python invalidates hash-based .pyc files
    inputBinding:
      position: 104
      prefix: --check-hash-based-pycs
  - id: cmd
    type:
      - 'null'
      - string
    doc: program passed in as string (terminates option list)
    inputBinding:
      position: 104
      prefix: -c
  - id: debug_parser
    type:
      - 'null'
      - boolean
    doc: turn on parser debugging output (for experts only, only works on debug 
      builds); also PYTHONDEBUG=x
    inputBinding:
      position: 104
      prefix: -d
  - id: dont_write_pyc
    type:
      - 'null'
      - boolean
    doc: don't write .pyc files on import; also PYTHONDONTWRITEBYTECODE=x
    inputBinding:
      position: 104
      prefix: -B
  - id: help_all
    type:
      - 'null'
      - boolean
    doc: print complete help information and exit
    inputBinding:
      position: 104
      prefix: --help-all
  - id: help_env
    type:
      - 'null'
      - boolean
    doc: print help about Python environment variables and exit
    inputBinding:
      position: 104
      prefix: --help-env
  - id: help_xoptions
    type:
      - 'null'
      - boolean
    doc: print help about implementation-specific -X options and exit
    inputBinding:
      position: 104
      prefix: --help-xoptions
  - id: ignore_environment
    type:
      - 'null'
      - boolean
    doc: ignore PYTHON* environment variables (such as PYTHONPATH)
    inputBinding:
      position: 104
      prefix: -E
  - id: implementation_option
    type:
      - 'null'
      - string
    doc: set implementation-specific option
    inputBinding:
      position: 104
      prefix: -X
  - id: inspect_interactively
    type:
      - 'null'
      - boolean
    doc: inspect interactively after running script; forces a prompt even if 
      stdin does not appear to be a terminal; also PYTHONINSPECT=x
    inputBinding:
      position: 104
      prefix: -i
  - id: isolate_environment
    type:
      - 'null'
      - boolean
    doc: isolate Python from the user's environment (implies -E and -s)
    inputBinding:
      position: 104
      prefix: -I
  - id: mod
    type:
      - 'null'
      - string
    doc: run library module as a script (terminates option list)
    inputBinding:
      position: 104
      prefix: -m
  - id: no_import_site
    type:
      - 'null'
      - boolean
    doc: don't imply 'import site' on initialization
    inputBinding:
      position: 104
      prefix: -S
  - id: no_unsafe_path
    type:
      - 'null'
      - boolean
    doc: don't prepend a potentially unsafe path to sys.path; also 
      PYTHONSAFEPATH
    inputBinding:
      position: 104
      prefix: -P
  - id: no_user_site
    type:
      - 'null'
      - boolean
    doc: don't add user site directory to sys.path; also PYTHONNOUSERSITE=x
    inputBinding:
      position: 104
      prefix: -s
  - id: optimize_level
    type:
      - 'null'
      - int
    doc: remove assert and __debug__-dependent statements; add .opt-1 before 
      .pyc extension; also PYTHONOPTIMIZE=x
    inputBinding:
      position: 104
      prefix: -O
  - id: optimize_level_2
    type:
      - 'null'
      - int
    doc: do -O changes and also discard docstrings; add .opt-2 before .pyc 
      extension
    inputBinding:
      position: 104
      prefix: -OO
  - id: print_version
    type:
      - 'null'
      - boolean
    doc: print the Python version number and exit (also --version)
    inputBinding:
      position: 104
      prefix: -V
  - id: quiet_startup
    type:
      - 'null'
      - boolean
    doc: don't print version and copyright messages on interactive startup
    inputBinding:
      position: 104
      prefix: -q
  - id: skip_first_line
    type:
      - 'null'
      - boolean
    doc: 'skip first line of source, allowing use of non-Unix forms of #!cmd'
    inputBinding:
      position: 104
      prefix: -x
  - id: unbuffered_streams
    type:
      - 'null'
      - boolean
    doc: force the stdout and stderr streams to be unbuffered; this option has 
      no effect on stdin; also PYTHONUNBUFFERED=x
    inputBinding:
      position: 104
      prefix: -u
  - id: verbose_import
    type:
      - 'null'
      - type: array
        items: boolean
    doc: verbose (trace import statements); also PYTHONVERBOSE=x, can be 
      supplied multiple times to increase verbosity
    inputBinding:
      position: 104
      prefix: -v
  - id: warn_bytes_str_conversion
    type:
      - 'null'
      - boolean
    doc: 'issue warnings about converting bytes/bytearray to str and comparing bytes/bytearray
      with str or bytes with int. (-bb: issue errors)'
    inputBinding:
      position: 104
      prefix: -b
  - id: warning_control
    type:
      - 'null'
      - string
    doc: warning control; arg is action:message:category:module:lineno, also 
      PYTHONWARNINGS=arg
    inputBinding:
      position: 104
      prefix: -W
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/python:3.13
stdout: python_python3.out
