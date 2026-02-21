cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-yaml
label: perl-test-yaml
doc: "A Perl-based tool for testing YAML. (Note: The provided text contains execution
  logs and an error indicating the executable was not found, rather than standard
  help documentation.)\n\nTool homepage: https://github.com/ingydotnet/test-yaml-pm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-yaml:1.07--pl526_0
stdout: perl-test-yaml.out
