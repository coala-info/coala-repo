cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-exception-class
label: perl-exception-class
doc: "A Perl module (Exception::Class) that allows for the declaration of real exception
  classes in Perl. Note: The provided text is an error log from a container runtime
  and does not contain CLI help information or arguments.\n\nTool homepage: http://metacpan.org/release/Exception-Class"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-exception-class:1.45--pl5321hdfd78af_0
stdout: perl-exception-class.out
