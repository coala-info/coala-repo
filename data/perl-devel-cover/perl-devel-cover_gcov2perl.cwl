cwlVersion: v1.2
class: CommandLineTool
baseCommand: gcov2perl
label: perl-devel-cover_gcov2perl
doc: "The provided text is a system error log indicating a failure to build or run
  a container due to insufficient disk space. It does not contain the help text or
  usage information for the tool 'gcov2perl'.\n\nTool homepage: http://www.pjcj.net/perl.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-devel-cover:1.33--pl526h14c3975_0
stdout: perl-devel-cover_gcov2perl.out
