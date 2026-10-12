cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsubpp
label: perl-extutils-parsexs
doc: Compiler to convert Perl XS code into C code
inputs:
  - id: file_xs
    type: File
    doc: XS source file to process
    inputBinding:
      position: 1
  - id: hiertype
    type:
      - 'null'
      - boolean
    doc: Retain '::' in type names so that C++ hierarchical types can be mapped
    inputBinding:
      position: 102
      prefix: -hiertype
  - id: output
    type:
      - 'null'
      - string
    doc: Name of the output file to generate (default is standard output)
    inputBinding:
      position: 102
      prefix: -output
  - id: csuffix
    type:
      - 'null'
      - string
    doc: Suffix for the generated C source file
    inputBinding:
      position: 102
      prefix: -csuffix
  - id: except
    type:
      - 'null'
      - boolean
    doc: Adds exception handling stubs to C code
    inputBinding:
      position: 102
      prefix: -except
  - id: prototypes
    type:
      - 'null'
      - boolean
    doc: Generate prototypes for C functions
    inputBinding:
      position: 102
      prefix: -prototypes
  - id: noversioncheck
    type:
      - 'null'
      - boolean
    doc: Do not check the version of XS against the perl binary
    inputBinding:
      position: 102
      prefix: -noversioncheck
  - id: nolinenumbers
    type:
      - 'null'
      - boolean
    doc: 'Prevent generation of #line directives in output'
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
  - id: noinout
    type:
      - 'null'
      - boolean
    doc: Disable IN/OUT/IN_OUT declarations
    inputBinding:
      position: 102
      prefix: -noinout
  - id: noargtypes
    type:
      - 'null'
      - boolean
    doc: Disable argument types checking
    inputBinding:
      position: 102
      prefix: -noargtypes
  - id: strip
    type:
      - 'null'
      - string
    doc: Strip pattern from function names
    inputBinding:
      position: 102
      prefix: -strip
  - id: typemap
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: -typemap
          separate: true
    doc: Specify typemap mapping file(s)
    inputBinding:
      position: 102
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: C source file written when the output option is used
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-extutils-parsexs:3.61--pl5321hdfd78af_0
stdout: xsubpp.out
s:url: https://metacpan.org/pod/ExtUtils::ParseXS
$namespaces:
  s: https://schema.org/
