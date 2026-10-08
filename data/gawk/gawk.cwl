cwlVersion: v1.2
class: CommandLineTool
baseCommand: gawk
label: gawk
doc: "pattern scanning and processing language\n\nTool homepage: https://www.gnu.org/software/gawk/"
inputs:
  - id: program_text
    type:
      - 'null'
      - string
    doc: AWK program source code (if --file or --source is not specified).
    inputBinding:
      position: 20
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to be processed.
    inputBinding:
      position: 21
  - id: assign
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --assign
    doc: "Assign the value val to the variable var (var=val), before execution of the program begins. Repeat for each variable."
    inputBinding:
      position: 5
  - id: field_separator
    type:
      - 'null'
      - string
    doc: "Use fs for the input field separator (the value of the FS predefined variable)."
    inputBinding:
      position: 5
      prefix: --field-separator
  - id: program_file
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --file
    doc: "Read the AWK program source from the file program-file, instead of from the first command line argument. Repeat for several files."
    inputBinding:
      position: 5
  - id: source
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --source
    doc: "Use program-text as AWK program source code (can be combined with --file)."
    inputBinding:
      position: 5
  - id: exec
    type:
      - 'null'
      - File
    doc: "Read the program from file and stop option processing (for #! scripts)."
    inputBinding:
      position: 5
      prefix: --exec
  - id: include
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --include
    doc: "Load an awk source library (includefile) before the program."
    inputBinding:
      position: 5
  - id: load
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --load
    doc: "Load a shared library (extension)."
    inputBinding:
      position: 5
  - id: characters_as_bytes
    type:
      - 'null'
      - boolean
    doc: "Treat all input data as single-byte characters."
    inputBinding:
      position: 5
      prefix: --characters-as-bytes
  - id: traditional
    type:
      - 'null'
      - boolean
    doc: "Run in compatibility mode (no GNU extensions)."
    inputBinding:
      position: 5
      prefix: --traditional
  - id: copyright
    type:
      - 'null'
      - boolean
    doc: "Print the short version of the GNU copyright information message."
    inputBinding:
      position: 5
      prefix: --copyright
  - id: gen_pot
    type:
      - 'null'
      - boolean
    doc: "Scan and parse the AWK program and generate a GNU .pot file on standard output."
    inputBinding:
      position: 5
      prefix: --gen-pot
  - id: trace
    type:
      - 'null'
      - boolean
    doc: "Print internal byte code names as they are executed."
    inputBinding:
      position: 5
      prefix: --trace
  - id: csv
    type:
      - 'null'
      - boolean
    doc: "Enable CSV special processing."
    inputBinding:
      position: 5
      prefix: --csv
  - id: bignum
    type:
      - 'null'
      - boolean
    doc: "Force arbitrary precision arithmetic on numbers."
    inputBinding:
      position: 5
      prefix: --bignum
  - id: use_lc_numeric
    type:
      - 'null'
      - boolean
    doc: "Force use of the locale's decimal point character when parsing input data."
    inputBinding:
      position: 5
      prefix: --use-lc-numeric
  - id: non_decimal_data
    type:
      - 'null'
      - boolean
    doc: "Recognize octal and hexadecimal values in input data."
    inputBinding:
      position: 5
      prefix: --non-decimal-data
  - id: optimize
    type:
      - 'null'
      - boolean
    doc: "Enable optimizations upon the internal representation of the program."
    inputBinding:
      position: 5
      prefix: --optimize
  - id: posix
    type:
      - 'null'
      - boolean
    doc: "Run in POSIX compatibility mode."
    inputBinding:
      position: 5
      prefix: --posix
  - id: re_interval
    type:
      - 'null'
      - boolean
    doc: "Allow interval expressions in regexps (default in gawk)."
    inputBinding:
      position: 5
      prefix: --re-interval
  - id: no_optimize
    type:
      - 'null'
      - boolean
    doc: "Disable gawk's default optimizations upon the internal representation of the program."
    inputBinding:
      position: 5
      prefix: --no-optimize
  - id: sandbox
    type:
      - 'null'
      - boolean
    doc: "Disable the system() function, input redirections with getline, output redirections with print and printf, and dynamic extensions."
    inputBinding:
      position: 5
      prefix: --sandbox
  - id: lint
    type:
      - 'null'
      - boolean
    doc: "Provide warnings about constructs that are dubious or non-portable to other AWK implementations."
    inputBinding:
      position: 5
      prefix: --lint
  - id: lint_old
    type:
      - 'null'
      - boolean
    doc: "Provide warnings about constructs that are not portable to the original version of Unix awk."
    inputBinding:
      position: 5
      prefix: --lint-old
  - id: lint_mode
    type:
      - 'null'
      - string
    doc: "Lint level: fatal, invalid or no-ext (passed as --lint=VALUE)."
    inputBinding:
      position: 5
      prefix: --lint=
      separate: false
  - id: dump_variables
    type:
      - 'null'
      - string
    doc: "Print a sorted list of global variables, their types and final values to this file (--dump-variables=file; default awkvars.out)."
    inputBinding:
      position: 5
      prefix: --dump-variables=
      separate: false
  - id: debug
    type:
      - 'null'
      - string
    doc: "Enable debugging of AWK programs (--debug=file reads debugger commands from the file)."
    inputBinding:
      position: 5
      prefix: --debug=
      separate: false
  - id: pretty_print
    type:
      - 'null'
      - string
    doc: "Output a pretty printed version of the program to this file (--pretty-print=file)."
    inputBinding:
      position: 5
      prefix: --pretty-print=
      separate: false
  - id: profile
    type:
      - 'null'
      - string
    doc: "Send profiling data to this file (--profile=file; default awkprof.out)."
    inputBinding:
      position: 5
      prefix: --profile=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: pretty_print_out
    type:
      - 'null'
      - File
    doc: Pretty printed program
    outputBinding:
      glob: $(inputs.pretty_print)
  - id: profile_out
    type:
      - 'null'
      - File
    doc: Profile data
    outputBinding:
      glob: $(inputs.profile)
  - id: dump_variables_out
    type:
      - 'null'
      - File
    doc: Dumped global variables
    outputBinding:
      glob: $(inputs.dump_variables)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gawk:5.3.1
stdout: gawk.out
