cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-cpan-meta-check
label: perl-cpan-meta-check
doc: "A tool to verify CPAN meta dependencies. (Note: The provided help text indicates
  an execution error and does not contain usage information.)\n\nTool homepage: http://metacpan.org/pod/CPAN::Meta::Check"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-cpan-meta-check:0.014--pl526_0
stdout: perl-cpan-meta-check.out
