cwlVersion: v1.2
class: CommandLineTool
baseCommand: perldoc
label: perl-business-isbn-data_perldoc
doc: "Display documentation from installed Perl modules.\n\nTool homepage: https://github.com/briandfoy/business-isbn-data"
inputs:
  - id: page_module_program_url
    type:
      type: array
      items: string
    doc: The name of a piece of documentation that you want to look at. You may 
      either give a descriptive name of the page (as in the case of `perlfunc') 
      the name of a module, either like `Term::Info' or like `Term/Info', or the
      name of a program, like `perldoc', or a URL starting with http(s).
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
  - id: builtin_function
    type:
      - 'null'
      - string
    doc: Search Perl built-in functions. Will extract documentation from 
      `perlfunc' or `perlop'.
    inputBinding:
      position: 102
      prefix: -f
  - id: display_module_file_entirety
    type:
      - 'null'
      - boolean
    doc: Display module's file in its entirety
    inputBinding:
      position: 102
      prefix: -m
  - id: display_module_file_name
    type:
      - 'null'
      - boolean
    doc: Display the module's file name
    inputBinding:
      position: 102
      prefix: -l
  - id: dont_drop_privs
    type:
      - 'null'
      - boolean
    doc: Don't attempt to drop privs for security
    inputBinding:
      position: 102
      prefix: -U
  - id: faq_regex
    type:
      - 'null'
      - string
    doc: Search the text of questions (not answers) in perlfaq[1-9] for and 
      extract any questions that match.
    inputBinding:
      position: 102
      prefix: -q
  - id: formatter_module
    type:
      - 'null'
      - string
    doc: FormatterModuleNameToUse
    inputBinding:
      position: 102
      prefix: -M
  - id: formatter_option
    type:
      - 'null'
      - string
    doc: formatter_option:option_value
    inputBinding:
      position: 102
      prefix: -w
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Ignore case
    inputBinding:
      position: 102
      prefix: -i
  - id: output_format
    type:
      - 'null'
      - string
    doc: output format name
    inputBinding:
      position: 102
      prefix: -o
  - id: perl_variable
    type:
      - 'null'
      - string
    doc: Search predefined Perl variables.
    inputBinding:
      position: 102
      prefix: -v
  - id: recursive_search
    type:
      - 'null'
      - boolean
    doc: Recursive search (slow)
    inputBinding:
      position: 102
      prefix: -r
  - id: search_perl_api
    type:
      - 'null'
      - boolean
    doc: Search Perl API
    inputBinding:
      position: 102
      prefix: -a
  - id: specify_groff_replacement
    type:
      - 'null'
      - string
    doc: Specify replacement for groff
    inputBinding:
      position: 102
      prefix: -n
  - id: stdout_no_pager
    type:
      - 'null'
      - boolean
    doc: Send output to STDOUT without any pager
    inputBinding:
      position: 102
      prefix: -T
  - id: translation_code
    type:
      - 'null'
      - string
    doc: Choose doc translation (if any)
    inputBinding:
      position: 102
      prefix: -L
  - id: unformatted_pod
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
    doc: Use index if present (looks for pod.idx at 
      .../../lib/perl5/5.32/core_perl)
    inputBinding:
      position: 102
      prefix: -X
  - id: use_pod2text
    type:
      - 'null'
      - boolean
    doc: Display pod using pod2text instead of Pod::Man and groff (-t is the 
      default on win32 unless -n is specified)
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose_description
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
    doc: output filename to send to
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-business-isbn-data:20210112.006--pl5321hdfd78af_0
