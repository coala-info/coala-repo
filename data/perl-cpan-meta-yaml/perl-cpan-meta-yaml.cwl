cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-cpan-meta-yaml
label: perl-cpan-meta-yaml
doc: "The provided text does not contain help information as the executable was not
  found in the environment. CPAN::Meta::YAML is typically a Perl module used to read
  and write a subset of YAML for CPAN Meta files.\n\nTool homepage: https://github.com/Perl-Toolchain-Gang/CPAN-Meta-YAML"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-cpan-meta-yaml:0.018--pl526_0
stdout: perl-cpan-meta-yaml.out
