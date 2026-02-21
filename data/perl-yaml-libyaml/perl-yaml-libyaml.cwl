cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-yaml-libyaml
label: perl-yaml-libyaml
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: https://github.com/ingydotnet/yaml-libyaml-pm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-yaml-libyaml:0.66--pl526_1
stdout: perl-yaml-libyaml.out
