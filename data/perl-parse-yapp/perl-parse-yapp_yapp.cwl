cwlVersion: v1.2
class: CommandLineTool
baseCommand: yapp
label: perl-parse-yapp_yapp
doc: "A perl-based compiler for Parse::Yapp grammar files, used to generate parser
  modules.\n\nTool homepage: http://metacpan.org/pod/Parse::Yapp"
inputs:
  - id: grammar
    type: File
    doc: The grammar file. If no suffix is given, and the file does not exists, .yp
      is added
    inputBinding:
      position: 1
  - id: create_output_file
    type:
      - 'null'
      - boolean
    doc: Create a file <grammar>.output describing your parser
    inputBinding:
      position: 102
      prefix: -v
  - id: disable_line_numbering
    type:
      - 'null'
      - boolean
    doc: Disable source file line numbering embedded in your parser
    inputBinding:
      position: 102
      prefix: -n
  - id: module_name
    type:
      - 'null'
      - string
    doc: Give your parser module the name <module>; default is <grammar>
    inputBinding:
      position: 102
      prefix: -m
  - id: shebang
    type:
      - 'null'
      - string
    doc: Adds '#!<shebang>' as the very first line of the output file
    inputBinding:
      position: 102
      prefix: -b
  - id: standalone
    type:
      - 'null'
      - boolean
    doc: Create a standalone module in which the driver is included
    inputBinding:
      position: 102
      prefix: -s
  - id: template_file
    type:
      - 'null'
      - File
    doc: Uses the file <filename> as a template for creating the parser module file.
      Default is to use internal template defined in Parse::Yapp::Output
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Create the file <outfile> for your parser module. Default is <grammar>.pm
      or, if -m A::Module::Name is specified, Name.pm
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-parse-yapp:1.21--pl526_0
