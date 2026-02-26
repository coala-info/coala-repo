cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl
label: perl-text-template-simple_perl
doc: "Perl interpreter with various switches for script execution and configuration.\n\
  \nTool homepage: http://metacpan.org/pod/Text::Template::Simple"
inputs:
  - id: program_file
    type:
      - 'null'
      - File
    doc: The Perl script file to execute.
    inputBinding:
      position: 1
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments passed to the Perl script.
    inputBinding:
      position: 2
  - id: allow_unsafe_operations
    type:
      - 'null'
      - boolean
    doc: Allow unsafe operations.
    inputBinding:
      position: 103
      prefix: -U
  - id: assume_while_loop
    type:
      - 'null'
      - boolean
    doc: Assume "while (<>) { ... }" loop around program.
    inputBinding:
      position: 103
      prefix: -n
  - id: assume_while_loop_and_print
    type:
      - 'null'
      - boolean
    doc: Assume loop like -n but print line also, like sed.
    inputBinding:
      position: 103
      prefix: -p
  - id: autosplit
    type:
      - 'null'
      - boolean
    doc: Autosplit mode with -n or -p (splits $_ into @F).
    inputBinding:
      position: 103
      prefix: -a
  - id: check_syntax
    type:
      - 'null'
      - boolean
    doc: Check syntax only (runs BEGIN and CHECK blocks).
    inputBinding:
      position: 103
      prefix: -c
  - id: debugger
    type:
      - 'null'
      - string
    doc: Run program under debugger.
    inputBinding:
      position: 103
      prefix: -d
  - id: debugging_flags
    type:
      - 'null'
      - string
    doc: Set debugging flags (argument is a bit mask or alphabets).
    inputBinding:
      position: 103
      prefix: -D
  - id: disable_all_warnings
    type:
      - 'null'
      - boolean
    doc: Disable all warnings.
    inputBinding:
      position: 103
      prefix: -X
  - id: disable_sitelib_startup
    type:
      - 'null'
      - boolean
    doc: Don't do $sitelib/sitecustomize.pl at startup.
    inputBinding:
      position: 103
      prefix: -f
  - id: dump_core_after_parsing
    type:
      - 'null'
      - boolean
    doc: Dump core after parsing program.
    inputBinding:
      position: 103
      prefix: -u
  - id: edit_in_place
    type:
      - 'null'
      - string
    doc: Edit <> files in place (makes backup if extension supplied).
    inputBinding:
      position: 103
      prefix: -i
  - id: enable_all_warnings
    type:
      - 'null'
      - boolean
    doc: Enable all warnings.
    inputBinding:
      position: 103
      prefix: -W
  - id: enable_tainting_checks
    type:
      - 'null'
      - boolean
    doc: Enable tainting checks.
    inputBinding:
      position: 103
      prefix: -T
  - id: enable_tainting_warnings
    type:
      - 'null'
      - boolean
    doc: Enable tainting warnings.
    inputBinding:
      position: 103
      prefix: -t
  - id: enable_unicode_features
    type:
      - 'null'
      - string
    doc: Enables the listed Unicode features.
    inputBinding:
      position: 103
      prefix: -C
  - id: enable_useful_warnings
    type:
      - 'null'
      - boolean
    doc: Enable many useful warnings.
    inputBinding:
      position: 103
      prefix: -w
  - id: execute_program
    type:
      - 'null'
      - string
    doc: One line of program (several -e's allowed, omit programfile).
    inputBinding:
      position: 103
      prefix: -e
  - id: execute_program_with_all_features
    type:
      - 'null'
      - string
    doc: Like -e, but enables all optional features.
    inputBinding:
      position: 103
      prefix: -E
  - id: ignore_text_before_shebang
    type:
      - 'null'
      - Directory
    doc: 'Ignore text before #!perl line (optionally cd to directory).'
    inputBinding:
      position: 103
      prefix: -x
  - id: include_directory
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Specify @INC/#include directory (several -I's allowed).
    inputBinding:
      position: 103
      prefix: -I
  - id: line_ending_processing
    type:
      - 'null'
      - string
    doc: Enable line ending processing, specifies line terminator.
    inputBinding:
      position: 103
      prefix: -l
  - id: look_for_program_in_path
    type:
      - 'null'
      - boolean
    doc: Look for programfile using PATH environment variable.
    inputBinding:
      position: 103
      prefix: -S
  - id: no_module
    type:
      - 'null'
      - string
    doc: Execute "no module..." before executing program.
    inputBinding:
      position: 103
      prefix: -M
  - id: print_configuration_summary
    type:
      - 'null'
      - string
    doc: Print configuration summary (or a single Config.pm variable).
    inputBinding:
      position: 103
      prefix: -V
  - id: print_version
    type:
      - 'null'
      - boolean
    doc: Print version, patchlevel and license.
    inputBinding:
      position: 103
      prefix: -v
  - id: record_separator
    type:
      - 'null'
      - string
    doc: Specify record separator (\0 if no argument).
    inputBinding:
      position: 103
      prefix: '-0'
  - id: rudimentary_switch_parsing
    type:
      - 'null'
      - boolean
    doc: Enable rudimentary parsing for switches after programfile.
    inputBinding:
      position: 103
      prefix: -s
  - id: split_pattern
    type:
      - 'null'
      - string
    doc: Split() pattern for -a switch (//'s are optional).
    inputBinding:
      position: 103
      prefix: -F
  - id: use_module
    type:
      - 'null'
      - string
    doc: Execute "use module..." before executing program.
    inputBinding:
      position: 103
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-text-template-simple:0.91--pl526_0
stdout: perl-text-template-simple_perl.out
