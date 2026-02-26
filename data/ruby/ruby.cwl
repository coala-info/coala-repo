cwlVersion: v1.2
class: CommandLineTool
baseCommand: ruby
label: ruby
doc: "Execute a Ruby script\n\nTool homepage: https://github.com/krahets/hello-algo"
inputs:
  - id: programfile
    type:
      - 'null'
      - File
    doc: The Ruby script file to execute
    inputBinding:
      position: 1
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments to pass to the script
    inputBinding:
      position: 2
  - id: assume_gets_loop
    type:
      - 'null'
      - boolean
    doc: Assume 'while gets(); ... end' loop around your script
    inputBinding:
      position: 103
      prefix: -n
  - id: assume_gets_print_loop
    type:
      - 'null'
      - boolean
    doc: Assume loop like -n but print line also like sed
    inputBinding:
      position: 103
      prefix: -p
  - id: autosplit
    type:
      - 'null'
      - boolean
    doc: Autosplit mode with -n or -p (splits $_ into $F)
    inputBinding:
      position: 103
      prefix: -a
  - id: cd_directory
    type:
      - 'null'
      - Directory
    doc: cd to directory before executing your script
    inputBinding:
      position: 103
      prefix: -C
  - id: check_syntax
    type:
      - 'null'
      - boolean
    doc: Check syntax only
    inputBinding:
      position: 103
      prefix: -c
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Set debugging flags (set $DEBUG to true)
    inputBinding:
      position: 103
      prefix: --debug
  - id: disable_feature
    type:
      - 'null'
      - type: array
        items: string
    doc: Disable features
    inputBinding:
      position: 103
      prefix: --disable
  - id: edit_in_place
    type:
      - 'null'
      - string
    doc: Edit ARGV files in place (make backup if extension supplied)
    inputBinding:
      position: 103
      prefix: -i
  - id: enable_feature
    type:
      - 'null'
      - type: array
        items: string
    doc: Enable features
    inputBinding:
      position: 103
      prefix: --enable
  - id: enable_switch_parsing
    type:
      - 'null'
      - boolean
    doc: Enable some switch parsing for switches after script name
    inputBinding:
      position: 103
      prefix: -s
  - id: encoding
    type:
      - 'null'
      - string
    doc: Specify the default external and internal character encodings
    inputBinding:
      position: 103
      prefix: --encoding
  - id: execute_command
    type:
      - 'null'
      - type: array
        items: string
    doc: One line of script. Several -e's allowed. Omit [programfile]
    inputBinding:
      position: 103
      prefix: -e
  - id: external_encoding
    type:
      - 'null'
      - string
    doc: Specify the default external character encoding
    inputBinding:
      position: 103
      prefix: --external-encoding
  - id: internal_encoding
    type:
      - 'null'
      - string
    doc: Specify the default internal character encoding
    inputBinding:
      position: 103
      prefix: --internal-encoding
  - id: line_ending_processing
    type:
      - 'null'
      - boolean
    doc: Enable line ending processing
    inputBinding:
      position: 103
      prefix: -l
  - id: load_path_directory
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Specify $LOAD_PATH directory (may be used more than once)
    inputBinding:
      position: 103
      prefix: -I
  - id: print_copyright
    type:
      - 'null'
      - boolean
    doc: Print the copyright
    inputBinding:
      position: 103
      prefix: --copyright
  - id: record_separator
    type:
      - 'null'
      - string
    doc: Specify record separator (\0, if no argument)
    default: \0
    inputBinding:
      position: 103
      prefix: '-0'
  - id: require_library
    type:
      - 'null'
      - type: array
        items: string
    doc: Require the library before executing your script
    inputBinding:
      position: 103
      prefix: -r
  - id: split_pattern
    type:
      - 'null'
      - string
    doc: Split() pattern for autosplit (-a)
    inputBinding:
      position: 103
      prefix: -F
  - id: strip_text_and_cd
    type:
      - 'null'
      - Directory
    doc: 'Strip off text before #!ruby line and perhaps cd to directory'
    inputBinding:
      position: 103
      prefix: -x
  - id: tainting_checks
    type:
      - 'null'
      - int
    doc: Turn on tainting checks
    default: 1
    inputBinding:
      position: 103
      prefix: -T
  - id: use_path_env
    type:
      - 'null'
      - boolean
    doc: Look for the script using PATH environment variable
    inputBinding:
      position: 103
      prefix: -S
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print version number, then turn on verbose mode
    inputBinding:
      position: 103
      prefix: --verbose
  - id: warning_level
    type:
      - 'null'
      - int
    doc: Set warning level; 0=silence, 1=medium, 2=verbose
    default: 2
    inputBinding:
      position: 103
      prefix: -W
  - id: warnings
    type:
      - 'null'
      - boolean
    doc: Turn warnings on for your script
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ruby:2.2.3--1
stdout: ruby.out
