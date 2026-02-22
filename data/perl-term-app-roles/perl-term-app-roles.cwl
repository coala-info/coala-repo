cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-term-app-roles
label: perl-term-app-roles
doc: "Term::App::Roles is a Perl module collection that provides various roles for
  terminal applications. (Note: The provided text contains system error messages regarding
  disk space and container image building rather than the tool's help documentation.)\n\
  \nTool homepage: https://metacpan.org/release/Term-App-Roles"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-term-app-roles:0.031--pl5321hdfd78af_0
stdout: perl-term-app-roles.out
