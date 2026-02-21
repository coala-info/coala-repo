cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-class-std-fast
label: perl-class-std-fast
doc: "A Perl module (Class::Std::Fast) providing a faster implementation of Class::Std.
  Note: The provided text indicates a execution failure and does not contain usage
  instructions.\n\nTool homepage: https://github.com/pld-linux/perl-Class-Std-Fast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-class-std-fast:0.0.8--pl526_1
stdout: perl-class-std-fast.out
