cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-module-list
label: perl-module-list
doc: "A tool to list Perl modules. (Note: The provided text contains system error
  messages regarding container image building and does not include the tool's help
  documentation or usage instructions.)\n\nTool homepage: http://metacpan.org/pod/Module::List"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-module-list:0.005--pl5321hdfd78af_0
stdout: perl-module-list.out
