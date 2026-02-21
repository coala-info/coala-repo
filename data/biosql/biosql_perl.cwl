cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/bin/perl
label: biosql_perl
doc: "Perl interpreter for executing scripts, often used in BioSQL workflows\n\nTool
  homepage: https://github.com/biosql/biosql"
inputs:
  - id: program_file
    type:
      - 'null'
      - File
    doc: The perl script to execute
    inputBinding:
      position: 1
  - id: script_arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments passed to the program file
    inputBinding:
      position: 2
  - id: autosplit_mode
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
      prefix: -V
  - id: debugger
    type:
      - 'null'
      - string
    doc: run program under debugger
    inputBinding:
      position: 103
      prefix: -d
  - id: debugging_flags
    type:
      - 'null'
      - string
    doc: set debugging flags (argument is a bit mask or alphabets)
    inputBinding:
      position: 103
      prefix: -D
  - id: disable_all_warnings
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
  - id: edit_inplace
    type:
      - 'null'
      - string
    doc: edit <> files in place (makes backup if extension supplied)
    inputBinding:
      position: 103
      prefix: -i
  - id: enable_all_warnings
    type:
      - 'null'
      - boolean
    doc: enable all warnings
    inputBinding:
      position: 103
      prefix: -W
  - id: enable_warnings
    type:
      - 'null'
      - boolean
    doc: enable many useful warnings
    inputBinding:
      position: 103
      prefix: -w
  - id: execute_command
    type:
      - 'null'
      - type: array
        items: string
    doc: one line of program (several -e's allowed, omit programfile)
    inputBinding:
      position: 103
      prefix: -e
  - id: execute_command_features
    type:
      - 'null'
      - type: array
        items: string
    doc: like -e, but enables all optional features
    inputBinding:
      position: 103
      prefix: -E
  - id: extract_program
    type:
      - 'null'
      - Directory
    doc: 'ignore text before #!perl line (optionally cd to directory)'
    inputBinding:
      position: 103
      prefix: -x
  - id: include_directory
    type:
      - 'null'
      - type: array
        items: Directory
    doc: specify @INC/#include directory (several -I's allowed)
    inputBinding:
      position: 103
      prefix: -I
  - id: line_ending_processing
    type:
      - 'null'
      - string
    doc: enable line ending processing, specifies line terminator
    inputBinding:
      position: 103
      prefix: -l
  - id: load_module
    type:
      - 'null'
      - type: array
        items: string
    doc: execute 'use module...' before executing program
    inputBinding:
      position: 103
      prefix: -m
  - id: load_module_import
    type:
      - 'null'
      - type: array
        items: string
    doc: execute 'use module...' before executing program
    inputBinding:
      position: 103
      prefix: -M
  - id: loop_while
    type:
      - 'null'
      - boolean
    doc: assume 'while (<>) { ... }' loop around program
    inputBinding:
      position: 103
      prefix: -n
  - id: loop_while_print
    type:
      - 'null'
      - boolean
    doc: assume loop like -n but print line also, like sed
    inputBinding:
      position: 103
      prefix: -p
  - id: record_separator
    type:
      - 'null'
      - string
    doc: specify record separator (\0, if no argument)
    inputBinding:
      position: 103
      prefix: '-0'
  - id: search_path
    type:
      - 'null'
      - boolean
    doc: look for programfile using PATH environment variable
    inputBinding:
      position: 103
      prefix: -S
  - id: skip_sitecustomize
    type:
      - 'null'
      - boolean
    doc: don't do $sitelib/sitecustomize.pl at startup
    inputBinding:
      position: 103
      prefix: -f
  - id: split_pattern
    type:
      - 'null'
      - string
    doc: split() pattern for -a switch (//'s are optional)
    inputBinding:
      position: 103
      prefix: -F
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
      prefix: -C
  - id: unsafe_operations
    type:
      - 'null'
      - boolean
    doc: allow unsafe operations
    inputBinding:
      position: 103
      prefix: -U
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biosql:v1.68dfsg-3-deb-py2_cv1
stdout: biosql_perl.out
