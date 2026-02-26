cwlVersion: v1.2
class: CommandLineTool
baseCommand: ttree
label: perl-template-toolkit_ttree
doc: "Process entire directory trees of templates using the Template Toolkit\n\nTool
  homepage: https://metacpan.org/pod/Template::Toolkit"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to process
    inputBinding:
      position: 1
  - id: absolute
    type:
      - 'null'
      - boolean
    doc: Enable the ABSOLUTE option
    inputBinding:
      position: 102
      prefix: --absolute
  - id: accept
    type:
      - 'null'
      - type: array
        items: string
    doc: Process only files matching REGEX
    inputBinding:
      position: 102
      prefix: --accept
  - id: all
    type:
      - 'null'
      - boolean
    doc: Process all files, regardless of modification
    inputBinding:
      position: 102
      prefix: --all
  - id: anycase
    type:
      - 'null'
      - boolean
    doc: Accept directive keywords in any case.
    inputBinding:
      position: 102
      prefix: --anycase
  - id: binmode
    type:
      - 'null'
      - string
    doc: Set binary mode of output files
    inputBinding:
      position: 102
      prefix: --binmode
  - id: cfg
    type:
      - 'null'
      - Directory
    doc: Location of configuration files
    inputBinding:
      position: 102
      prefix: --cfg
  - id: color
    type:
      - 'null'
      - boolean
    doc: Enable colo(u)rful verbose output.
    inputBinding:
      position: 102
      prefix: --color
  - id: compile_dir
    type:
      - 'null'
      - Directory
    doc: Directory for compiled template files
    inputBinding:
      position: 102
      prefix: --compile_dir
  - id: compile_ext
    type:
      - 'null'
      - string
    doc: File extension for compiled template files
    inputBinding:
      position: 102
      prefix: --compile_ext
  - id: copy
    type:
      - 'null'
      - type: array
        items: string
    doc: Copy files matching REGEX
    inputBinding:
      position: 102
      prefix: --copy
  - id: copy_dir
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Copy files in dir DIR (recursive)
    inputBinding:
      position: 102
      prefix: --copy_dir
  - id: debug
    type:
      - 'null'
      - string
    doc: Set TT DEBUG option to STRING
    inputBinding:
      position: 102
      prefix: --debug
  - id: default
    type:
      - 'null'
      - string
    doc: Use TEMPLATE as default
    inputBinding:
      position: 102
      prefix: --default
  - id: define
    type:
      - 'null'
      - string
    doc: Define template variable
    inputBinding:
      position: 102
      prefix: --define
  - id: depend
    type:
      - 'null'
      - string
    doc: Specify that 'foo' depends on 'bar' and 'baz'.
    inputBinding:
      position: 102
      prefix: --depend
  - id: depend_debug
    type:
      - 'null'
      - boolean
    doc: Enable debugging for dependencies
    inputBinding:
      position: 102
      prefix: --depend_debug
  - id: depend_file
    type:
      - 'null'
      - File
    doc: Read file dependancies from FILE.
    inputBinding:
      position: 102
      prefix: --depend_file
  - id: encoding
    type:
      - 'null'
      - string
    doc: Set encoding of input files
    inputBinding:
      position: 102
      prefix: --encoding
  - id: end_tag
    type:
      - 'null'
      - string
    doc: STRING defined end of directive tag
    inputBinding:
      position: 102
      prefix: --end_tag
  - id: error
    type:
      - 'null'
      - string
    doc: Use TEMPLATE to handle errors
    inputBinding:
      position: 102
      prefix: --error
  - id: eval_perl
    type:
      - 'null'
      - boolean
    doc: Evaluate [% PERL %] ... [% END %] code blocks
    inputBinding:
      position: 102
      prefix: --eval_perl
  - id: file
    type:
      - 'null'
      - type: array
        items: File
    doc: Read named configuration file
    inputBinding:
      position: 102
      prefix: --file
  - id: ignore
    type:
      - 'null'
      - type: array
        items: string
    doc: Ignore files matching REGEX
    inputBinding:
      position: 102
      prefix: --ignore
  - id: interpolate
    type:
      - 'null'
      - boolean
    doc: Interpolate '$var' references in text
    inputBinding:
      position: 102
      prefix: --interpolate
  - id: lib
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Library directory (INCLUDE_PATH)
    inputBinding:
      position: 102
      prefix: --lib
  - id: link
    type:
      - 'null'
      - type: array
        items: string
    doc: Link files matching REGEX
    inputBinding:
      position: 102
      prefix: --link
  - id: load_perl
    type:
      - 'null'
      - boolean
    doc: Load regular Perl modules via USE directive
    inputBinding:
      position: 102
      prefix: --load_perl
  - id: nothing
    type:
      - 'null'
      - boolean
    doc: Do nothing, just print summary (enables -v)
    inputBinding:
      position: 102
      prefix: --nothing
  - id: perl5lib
    type:
      - 'null'
      - Directory
    doc: Specify additional Perl library directories
    inputBinding:
      position: 102
      prefix: --perl5lib
  - id: plugin_base
    type:
      - 'null'
      - string
    doc: Base PACKAGE for plugins
    inputBinding:
      position: 102
      prefix: --plugin_base
  - id: post_chomp
    type:
      - 'null'
      - boolean
    doc: Chomp trailing whitespace
    inputBinding:
      position: 102
      prefix: --post_chomp
  - id: post_process
    type:
      - 'null'
      - string
    doc: Process TEMPLATE after each main template
    inputBinding:
      position: 102
      prefix: --post_process
  - id: pre_chomp
    type:
      - 'null'
      - boolean
    doc: Chomp leading whitespace
    inputBinding:
      position: 102
      prefix: --pre_chomp
  - id: pre_process
    type:
      - 'null'
      - string
    doc: Process TEMPLATE before each main template
    inputBinding:
      position: 102
      prefix: --pre_process
  - id: preserve
    type:
      - 'null'
      - boolean
    doc: Preserve file ownership and permission
    inputBinding:
      position: 102
      prefix: --preserve
  - id: process
    type:
      - 'null'
      - string
    doc: Process TEMPLATE instead of main template
    inputBinding:
      position: 102
      prefix: --process
  - id: recurse
    type:
      - 'null'
      - boolean
    doc: Recurse into sub-directories
    inputBinding:
      position: 102
      prefix: --recurse
  - id: relative
    type:
      - 'null'
      - boolean
    doc: Enable the RELATIVE option
    inputBinding:
      position: 102
      prefix: --relative
  - id: src
    type:
      - 'null'
      - Directory
    doc: Source directory
    inputBinding:
      position: 102
      prefix: --src
  - id: start_tag
    type:
      - 'null'
      - string
    doc: STRING defines start of directive tag
    inputBinding:
      position: 102
      prefix: --start_tag
  - id: suffix
    type:
      - 'null'
      - type: array
        items: string
    doc: Change any '.old' suffix to '.new'
    inputBinding:
      position: 102
      prefix: --suffix
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Show processing summary.
    inputBinding:
      position: 102
      prefix: --summary
  - id: tag_style
    type:
      - 'null'
      - string
    doc: Use pre-defined tag STYLE
    inputBinding:
      position: 102
      prefix: --tag_style
  - id: template_module
    type:
      - 'null'
      - string
    doc: Specify alternate Template module
    inputBinding:
      position: 102
      prefix: --template_module
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Trim blank lines around template blocks
    inputBinding:
      position: 102
      prefix: --trim
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: 'Verbose mode. Use twice for more verbosity: -v -v'
    inputBinding:
      position: 102
      prefix: --verbose
  - id: wrapper
    type:
      - 'null'
      - string
    doc: Process TEMPLATE wrapper around main template
    inputBinding:
      position: 102
      prefix: --wrapper
outputs:
  - id: dest
    type:
      - 'null'
      - Directory
    doc: Destination directory
    outputBinding:
      glob: $(inputs.dest)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-template-toolkit:3.102--pl5321h7b50bb2_1
