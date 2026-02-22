cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-class-methodmaker
label: perl-class-methodmaker
doc: "Class::MethodMaker - a Perl module for creating methods in user-defined classes.
  (Note: The provided text is an error log regarding container execution and does
  not contain help documentation or argument definitions).\n\nTool homepage: http://search.cpan.org/~schwigon/Class-MethodMaker-2.24/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-class-methodmaker:2.25--pl5321h7b50bb2_1
stdout: perl-class-methodmaker.out
