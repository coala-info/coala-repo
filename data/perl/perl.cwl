cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl
doc: "The Perl 5 language interpreter\n\nTool homepage: https://github.com/major/MySQLTuner-perl"
inputs:
  - id: program_file
    type:
      - 'null'
      - File
    doc: Program file to execute
    inputBinding:
      position: 200
  - id: arguments
    type:
      - 'null'
      - type: array
        items:
          - string
          - File
    doc: Arguments passed to the program file (strings or input files)
    inputBinding:
      position: 201
  - id: all_warnings
    type:
      - 'null'
      - boolean
    doc: enable all warnings
    inputBinding:
      position: 103
      prefix: -W
  - id: assume_print_loop
    type:
      - 'null'
      - boolean
    doc: assume loop like -n but print line also, like sed
    inputBinding:
      position: 103
      prefix: -p
  - id: assume_while_loop
    type:
      - 'null'
      - boolean
    doc: assume 'while (<>) { ... }' loop around program
    inputBinding:
      position: 103
      prefix: -n
  - id: autosplit
    type:
      - 'null'
      - boolean
    doc: autosplit mode with -n or -p (splits $_ into @F)
    inputBinding:
      position: 103
      prefix: -a
  - id: check_syntax
    type:
      - 'null'
      - boolean
    doc: check syntax only (runs BEGIN and CHECK blocks)
    inputBinding:
      position: 103
      prefix: -c
  - id: config_summary
    type:
      - 'null'
      - string
    doc: print configuration summary (or a single Config.pm variable)
    inputBinding:
      position: 103
      prefix: '-d:'
      separate: false
  - id: debugger
    type:
      - 'null'
      - string
    doc: run program under debugger
    inputBinding:
      position: 103
      prefix: '-d:'
      separate: false
  - id: debugging_flags
    type:
      - 'null'
      - string
    doc: set debugging flags (argument is a bit mask or alphabets)
    inputBinding:
      position: 103
      prefix: '-D'
      separate: false
  - id: disable_warnings
    type:
      - 'null'
      - boolean
    doc: disable all warnings
    inputBinding:
      position: 103
      prefix: -X
  - id: dump_core
    type:
      - 'null'
      - boolean
    doc: dump core after parsing program
    inputBinding:
      position: 103
      prefix: -u
  - id: execute_command
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -e
    doc: one line of program (several -e's allowed, omit programfile)
    inputBinding:
      position: 103
  - id: execute_command_features
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -E
    doc: like -e, but enables all optional features
    inputBinding:
      position: 103
  - id: ignore_text
    type:
      - 'null'
      - Directory
    doc: 'ignore text before #!perl line (optionally cd to directory)'
    inputBinding:
      position: 103
      prefix: '-x'
      separate: false
  - id: include_directory
    type:
      - 'null'
      - type: array
        items: Directory
        inputBinding:
          prefix: -I
    doc: specify @INC/#include directory (several -I's allowed)
    inputBinding:
      position: 103
  - id: inplace_edit
    type:
      - 'null'
      - string
    doc: edit <> files in place (makes backup if extension supplied)
    inputBinding:
      position: 103
      prefix: '-i'
      separate: false
  - id: line_ending_processing
    type:
      - 'null'
      - string
    doc: enable line ending processing, specifies line terminator
    inputBinding:
      position: 103
      prefix: '-l'
      separate: false
  - id: module
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -m
          separate: false
    doc: execute 'use/no module...' before executing program
    inputBinding:
      position: 103
  - id: no_sitecustomize
    type:
      - 'null'
      - boolean
    doc: don't do $sitelib/sitecustomize.pl at startup
    inputBinding:
      position: 103
      prefix: -f
  - id: record_separator
    type:
      - 'null'
      - string
    doc: specify record separator (\0, if no argument)
    inputBinding:
      position: 103
      prefix: '-0'
      separate: false
  - id: search_path
    type:
      - 'null'
      - boolean
    doc: look for programfile using PATH environment variable
    inputBinding:
      position: 103
      prefix: -S
  - id: split_pattern
    type:
      - 'null'
      - string
    doc: split() pattern for -a switch (//'s are optional)
    inputBinding:
      position: 103
      prefix: '-F'
      separate: false
  - id: switch_parsing
    type:
      - 'null'
      - boolean
    doc: enable rudimentary parsing for switches after programfile
    inputBinding:
      position: 103
      prefix: -s
  - id: taint_checks
    type:
      - 'null'
      - boolean
    doc: enable tainting checks
    inputBinding:
      position: 103
      prefix: -T
  - id: taint_warnings
    type:
      - 'null'
      - boolean
    doc: enable tainting warnings
    inputBinding:
      position: 103
      prefix: -t
  - id: unicode_features
    type:
      - 'null'
      - string
    doc: enables the listed Unicode features
    inputBinding:
      position: 103
      prefix: '-C'
      separate: false
  - id: unsafe_operations
    type:
      - 'null'
      - boolean
    doc: allow unsafe operations
    inputBinding:
      position: 103
      prefix: -U
  - id: warnings
    type:
      - 'null'
      - boolean
    doc: enable many useful warnings
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl:5.32
stdout: perl.out
