cwlVersion: v1.2
class: CommandLineTool
baseCommand: pod2usage
label: perl-pod-usage_pod2usage
doc: "Print usage messages from a file's pod documentation\n\nTool homepage: http://search.cpan.org/~marekr/Pod-Usage-1.69/"
inputs:
  - id: file
    type:
      - 'null'
      - File
    doc: The pathname of a file containing pod documentation to be output in usage
      message format (defaults to standard input).
    inputBinding:
      position: 1
  - id: exit_val
    type:
      - 'null'
      - int
    doc: The exit status value to return.
    inputBinding:
      position: 102
      prefix: -exit
  - id: formatter
    type:
      - 'null'
      - string
    doc: Which text formatter to use. Default is Pod::Text, or for very old Perl versions
      Pod::PlainText.
    inputBinding:
      position: 102
      prefix: -formatter
  - id: pathlist
    type:
      - 'null'
      - string
    doc: Specifies one or more directories to search for the input file if it was
      not supplied with an absolute path. Each directory path in the given list should
      be separated by a ':' on Unix (';' on MSWin32 and DOS).
    inputBinding:
      position: 102
      prefix: -pathlist
  - id: utf8
    type:
      - 'null'
      - boolean
    doc: This option assumes that the formatter understands the option "utf8". It
      turns on generation of utf8 output.
    inputBinding:
      position: 102
      prefix: -utf8
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: 'The desired level of verbosity to use: 1 (SYNOPSIS), 2 (SYNOPSIS and OPTIONS/ARGUMENTS),
      or 3 (entire manpage).'
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output file to print to. If the special names "-" or ">&1" or ">&STDOUT"
      are used then standard output is used. If ">&2" or ">&STDERR" is used then standard
      error is used.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pod-usage:2.05--pl5321hdfd78af_0
