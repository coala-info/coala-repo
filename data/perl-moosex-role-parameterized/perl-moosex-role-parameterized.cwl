cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-moosex-role-parameterized
label: perl-moosex-role-parameterized
doc: "MooseX::Role::Parameterized is a Perl module that allows roles to accept parameters
  at composition time. The provided text is an error log indicating a failure to pull
  or build the container image due to lack of disk space, and does not contain CLI
  help information.\n\nTool homepage: https://github.com/moose/MooseX-Role-Parameterized"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-moosex-role-parameterized:1.11--pl5321hdfd78af_0
stdout: perl-moosex-role-parameterized.out
