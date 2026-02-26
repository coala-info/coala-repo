cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-extutils-makemaker_perl
doc: "Run Perl scripts\n\nTool homepage: https://metacpan.org/release/ExtUtils-MakeMaker"
inputs:
  - id: switches
    type:
      - 'null'
      - string
    doc: Perl switches
    inputBinding:
      position: 1
  - id: programfile
    type:
      - 'null'
      - File
    doc: Perl program file
    inputBinding:
      position: 2
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments to the Perl program
    inputBinding:
      position: 3
  - id: autosplit
    type:
      - 'null'
      - boolean
    doc: autosplit mode with -n or -p (splits $_ into @F)
    inputBinding:
      position: 104
      prefix: -a
  - id: check_syntax
    type:
      - 'null'
      - boolean
    doc: check syntax only (runs BEGIN and CHECK blocks)
    inputBinding:
      position: 104
      prefix: -c
  - id: config_summary
    type:
      - 'null'
      - string
    doc: print configuration summary (or a single Config.pm variable)
    inputBinding:
      position: 104
      prefix: -V
  - id: debugger
    type:
      - 'null'
      - string
    doc: run program under debugger
    inputBinding:
      position: 104
      prefix: -d
  - id: debugging_flags
    type:
      - 'null'
      - string
    doc: set debugging flags (argument is a bit mask or alphabets)
    inputBinding:
      position: 104
      prefix: -D
  - id: disable_all_warnings
    type:
      - 'null'
      - boolean
    doc: disable all warnings
    inputBinding:
      position: 104
      prefix: -X
  - id: dump_core
    type:
      - 'null'
      - boolean
    doc: dump core after parsing program
    inputBinding:
      position: 104
      prefix: -u
  - id: enable_all_warnings
    type:
      - 'null'
      - boolean
    doc: enable all warnings
    inputBinding:
      position: 104
      prefix: -W
  - id: enable_warnings
    type:
      - 'null'
      - boolean
    doc: enable many useful warnings
    inputBinding:
      position: 104
      prefix: -w
  - id: execute_program
    type:
      - 'null'
      - string
    doc: one line of program (several -e's allowed, omit programfile)
    inputBinding:
      position: 104
      prefix: -e
  - id: execute_program_with_features
    type:
      - 'null'
      - string
    doc: like -e, but enables all optional features
    inputBinding:
      position: 104
      prefix: -E
  - id: ignore_text_before_shebang
    type:
      - 'null'
      - Directory
    doc: 'ignore text before #!perl line (optionally cd to directory)'
    inputBinding:
      position: 104
      prefix: -x
  - id: in_place_edit
    type:
      - 'null'
      - string
    doc: edit <> files in place (makes backup if extension supplied)
    inputBinding:
      position: 104
      prefix: -i
  - id: include_directory
    type:
      - 'null'
      - type: array
        items: Directory
    doc: specify @INC/#include directory (several -I's allowed)
    inputBinding:
      position: 104
      prefix: -I
  - id: line_ending_processing
    type:
      - 'null'
      - string
    doc: enable line ending processing, specifies line terminator
    inputBinding:
      position: 104
      prefix: -l
  - id: loop_and_print
    type:
      - 'null'
      - boolean
    doc: assume loop like -n but print line also, like sed
    inputBinding:
      position: 104
      prefix: -p
  - id: loop_around_program
    type:
      - 'null'
      - boolean
    doc: assume "while (<>) { ... }" loop around program
    inputBinding:
      position: 104
      prefix: -n
  - id: no_module
    type:
      - 'null'
      - string
    doc: execute "no module..." before executing program
    inputBinding:
      position: 104
      prefix: -M
  - id: no_sitelib_startup
    type:
      - 'null'
      - boolean
    doc: don't do $sitelib/sitecustomize.pl at startup
    inputBinding:
      position: 104
      prefix: -f
  - id: print_version
    type:
      - 'null'
      - boolean
    doc: print version, patchlevel and license
    inputBinding:
      position: 104
      prefix: -v
  - id: record_separator
    type:
      - 'null'
      - string
    doc: specify record separator (octal)
    inputBinding:
      position: 104
      prefix: '-0'
  - id: rudimentary_switch_parsing
    type:
      - 'null'
      - boolean
    doc: enable rudimentary parsing for switches after programfile
    inputBinding:
      position: 104
      prefix: -s
  - id: search_path
    type:
      - 'null'
      - boolean
    doc: look for programfile using PATH environment variable
    inputBinding:
      position: 104
      prefix: -S
  - id: split_pattern
    type:
      - 'null'
      - string
    doc: split() pattern for -a switch (//'s are optional)
    inputBinding:
      position: 104
      prefix: -F
  - id: tainting_checks
    type:
      - 'null'
      - boolean
    doc: enable tainting checks
    inputBinding:
      position: 104
      prefix: -T
  - id: tainting_warnings
    type:
      - 'null'
      - boolean
    doc: enable tainting warnings
    inputBinding:
      position: 104
      prefix: -t
  - id: unicode_features
    type:
      - 'null'
      - string
    doc: enables the listed Unicode features
    inputBinding:
      position: 104
      prefix: -C
  - id: unsafe_operations
    type:
      - 'null'
      - boolean
    doc: allow unsafe operations
    inputBinding:
      position: 104
      prefix: -U
  - id: use_module
    type:
      - 'null'
      - string
    doc: execute "use module..." before executing program
    inputBinding:
      position: 104
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-extutils-makemaker:7.36--pl526_1
stdout: perl-extutils-makemaker_perl.out
