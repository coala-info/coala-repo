cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-convert-binary-c
label: perl-convert-binary-c
doc: "A Perl module/tool for binary data conversion using C types. (Note: The provided
  help text is an error log indicating a failure to pull or run the container and
  does not contain usage information or arguments.)\n\nTool homepage: http://search.cpan.org/~mhx/Convert-Binary-C/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-convert-binary-c:0.86--pl5321h9948957_0
stdout: perl-convert-binary-c.out
