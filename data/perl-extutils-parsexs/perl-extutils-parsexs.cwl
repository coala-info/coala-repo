cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsubpp
label: perl-extutils-parsexs
doc: "Compiler to convert Perl XS code into C code\n\nTool homepage: https://metacpan.org/pod/ExtUtils::ParseXS"
inputs:
  - id: input_file
    type: File
    doc: The XS input file to be compiled
    inputBinding:
      position: 1
  - id: hiertype
    type:
      - 'null'
      - boolean
    doc: Retain hierarchy in keyword names
    inputBinding:
      position: 102
      prefix: -hiertype
  - id: nolinenumbers
    type:
      - 'null'
      - boolean
    doc: 'Prevent the generation of #line directives'
    inputBinding:
      position: 102
      prefix: -nolinenumbers
  - id: nooptimize
    type:
      - 'null'
      - boolean
    doc: Disable certain optimizations
    inputBinding:
      position: 102
      prefix: -nooptimize
  - id: noversioncheck
    type:
      - 'null'
      - boolean
    doc: Disable the XS version check
    inputBinding:
      position: 102
      prefix: -noversioncheck
  - id: prototypes
    type:
      - 'null'
      - boolean
    doc: Enable support for Perl prototypes
    inputBinding:
      position: 102
      prefix: -prototypes
  - id: typemap
    type:
      - 'null'
      - type: array
        items: File
    doc: Specify a typemap file to be used
    inputBinding:
      position: 102
      prefix: -typemap
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify the name of the output C file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-extutils-parsexs:3.61--pl5321hdfd78af_0
