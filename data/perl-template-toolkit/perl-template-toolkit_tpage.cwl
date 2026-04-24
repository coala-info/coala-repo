cwlVersion: v1.2
class: CommandLineTool
baseCommand: tpage
label: perl-template-toolkit_tpage
doc: "Process Template Toolkit templates from command line\n\nTool homepage: https://metacpan.org/pod/Template::Toolkit"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Template files to process
    inputBinding:
      position: 1
  - id: absolute
    type:
      - 'null'
      - boolean
    doc: Allow ABSOLUTE directories (enabled by default)
    inputBinding:
      position: 102
      prefix: --absolute
  - id: anycase
    type:
      - 'null'
      - boolean
    doc: Accept directive keywords in any case.
    inputBinding:
      position: 102
      prefix: --anycase
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
      - File
    doc: Use TEMPLATE as default
    inputBinding:
      position: 102
      prefix: --default
  - id: define
    type:
      - 'null'
      - type: array
        items: string
    doc: Define template variable (var=value)
    inputBinding:
      position: 102
      prefix: --define
  - id: end_tag
    type:
      - 'null'
      - string
    doc: STRING defined end of directive tag
    inputBinding:
      position: 102
      prefix: --end_tag
  - id: envvars
    type:
      - 'null'
      - boolean
    doc: Set the 'env' variable to the environment (%ENV)
    inputBinding:
      position: 102
      prefix: --envvars
  - id: error
    type:
      - 'null'
      - File
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
  - id: include_path
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Add directory to INCLUDE_PATH
    inputBinding:
      position: 102
      prefix: --include_path
  - id: interpolate
    type:
      - 'null'
      - boolean
    doc: Interpolate '$var' references in text
    inputBinding:
      position: 102
      prefix: --interpolate
  - id: load_perl
    type:
      - 'null'
      - boolean
    doc: Load regular Perl modules via USE directive
    inputBinding:
      position: 102
      prefix: --load_perl
  - id: perl5lib
    type:
      - 'null'
      - type: array
        items: Directory
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
      - File
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
      - File
    doc: Process TEMPLATE before each main template
    inputBinding:
      position: 102
      prefix: --pre_process
  - id: process
    type:
      - 'null'
      - File
    doc: Process TEMPLATE instead of main template
    inputBinding:
      position: 102
      prefix: --process
  - id: relative
    type:
      - 'null'
      - boolean
    doc: Allow RELATIVE directories (enabled by default)
    inputBinding:
      position: 102
      prefix: --relative
  - id: start_tag
    type:
      - 'null'
      - string
    doc: STRING defines start of directive tag
    inputBinding:
      position: 102
      prefix: --start_tag
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
  - id: while_max
    type:
      - 'null'
      - int
    doc: Change '$Template::Directive::WHILE_MAX' default
    inputBinding:
      position: 102
      prefix: --while_max
  - id: wrapper
    type:
      - 'null'
      - File
    doc: Process TEMPLATE wrapper around main template
    inputBinding:
      position: 102
      prefix: --wrapper
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-template-toolkit:3.102--pl5321h7b50bb2_1
stdout: perl-template-toolkit_tpage.out
