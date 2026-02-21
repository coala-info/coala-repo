cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-regexp-common_perl
doc: "The Perl 5 language interpreter\n\nTool homepage: http://metacpan.org/pod/Regexp::Common"
inputs:
  - id: program_file
    type:
      - 'null'
      - File
    doc: Program file to execute
    inputBinding:
      position: 1
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments passed to the program file
    inputBinding:
      position: 2
  - id: all_warnings
    type:
      - 'null'
      - boolean
    doc: enable all warnings
    inputBinding:
      position: 103
      prefix: -W
  - id: assume_while_loop
    type:
      - 'null'
      - boolean
    doc: assume "while (<>) { ... }" loop around program
    inputBinding:
      position: 103
      prefix: -n
  - id: assume_while_print_loop
    type:
      - 'null'
      - boolean
    doc: assume loop like -n but print line also, like sed
    inputBinding:
      position: 103
      prefix: -p
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
  - id: enable_switch_parsing
    type:
      - 'null'
      - boolean
    doc: enable rudimentary parsing for switches after programfile
    inputBinding:
      position: 103
      prefix: -s
  - id: execute_program
    type:
      - 'null'
      - type: array
        items: string
    doc: one line of program (several -e's allowed, omit programfile)
    inputBinding:
      position: 103
      prefix: -e
  - id: execute_program_features
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
  - id: inplace_edit
    type:
      - 'null'
      - string
    doc: edit <> files in place (makes backup if extension supplied)
    inputBinding:
      position: 103
      prefix: -i
  - id: line_ending_processing
    type:
      - 'null'
      - string
    doc: enable line ending processing, specifies line terminator
    inputBinding:
      position: 103
      prefix: -l
  - id: module
    type:
      - 'null'
      - type: array
        items: string
    doc: execute "use module..." before executing program
    inputBinding:
      position: 103
      prefix: -m
  - id: no_module
    type:
      - 'null'
      - type: array
        items: string
    doc: execute "no module..." before executing program
    inputBinding:
      position: 103
      prefix: -M
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
      prefix: -F
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
    dockerPull: quay.io/biocontainers/perl-regexp-common:2017060201--pl526_0
stdout: perl-regexp-common_perl.out
