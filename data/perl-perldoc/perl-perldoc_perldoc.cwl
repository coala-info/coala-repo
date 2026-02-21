cwlVersion: v1.2
class: CommandLineTool
baseCommand: perldoc
label: perl-perldoc_perldoc
doc: "Look up Perl documentation in Pod format.\n\nTool homepage: http://metacpan.org/pod/Perldoc"
inputs:
  - id: target
    type:
      - 'null'
      - type: array
        items: string
    doc: PageName, ModuleName, ProgramName, or URL to look up.
    inputBinding:
      position: 1
  - id: arguments_are_filenames
    type:
      - 'null'
      - boolean
    doc: Arguments are file names, not modules (implies -U)
    inputBinding:
      position: 102
      prefix: -F
  - id: display_filename
    type:
      - 'null'
      - boolean
    doc: Display the module's file name
    inputBinding:
      position: 102
      prefix: -l
  - id: display_module_file
    type:
      - 'null'
      - boolean
    doc: Display module's file in its entirety
    inputBinding:
      position: 102
      prefix: -m
  - id: formatter_module
    type:
      - 'null'
      - string
    doc: Formatter module name to use
    inputBinding:
      position: 102
      prefix: -M
  - id: formatter_option
    type:
      - 'null'
      - string
    doc: Formatter option (formatter_option:option_value)
    inputBinding:
      position: 102
      prefix: -w
  - id: groff_replacement
    type:
      - 'null'
      - string
    doc: Specify replacement for groff
    inputBinding:
      position: 102
      prefix: -n
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Ignore case
    inputBinding:
      position: 102
      prefix: -i
  - id: no_drop_privs
    type:
      - 'null'
      - boolean
    doc: Don't attempt to drop privs for security
    inputBinding:
      position: 102
      prefix: -U
  - id: no_pager
    type:
      - 'null'
      - boolean
    doc: Send output to STDOUT without any pager
    inputBinding:
      position: 102
      prefix: -T
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format name
    inputBinding:
      position: 102
      prefix: -o
  - id: recursive_search
    type:
      - 'null'
      - boolean
    doc: Recursive search (slow)
    inputBinding:
      position: 102
      prefix: -r
  - id: search_api
    type:
      - 'null'
      - boolean
    doc: Search Perl API
    inputBinding:
      position: 102
      prefix: -a
  - id: search_builtin
    type:
      - 'null'
      - string
    doc: Search Perl built-in functions
    inputBinding:
      position: 102
      prefix: -f
  - id: search_faq
    type:
      - 'null'
      - string
    doc: Search the text of questions (not answers) in perlfaq[1-9]
    inputBinding:
      position: 102
      prefix: -q
  - id: search_variables
    type:
      - 'null'
      - string
    doc: Search predefined Perl variables
    inputBinding:
      position: 102
      prefix: -v
  - id: translation_code
    type:
      - 'null'
      - string
    doc: Choose doc translation (if any)
    inputBinding:
      position: 102
      prefix: -L
  - id: unformatted
    type:
      - 'null'
      - boolean
    doc: Display unformatted pod text
    inputBinding:
      position: 102
      prefix: -u
  - id: use_index
    type:
      - 'null'
      - boolean
    doc: Use index if present
    inputBinding:
      position: 102
      prefix: -X
  - id: use_pod2text
    type:
      - 'null'
      - boolean
    doc: Display pod using pod2text instead of Pod::Man and groff
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbosely describe what's going on
    inputBinding:
      position: 102
      prefix: -D
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Output filename to send to
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-perldoc:0.20--pl5321hdfd78af_0
