cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-requiresinternet
label: perl-test-requiresinternet
doc: "A tool to test for internet connectivity, typically used in Perl testing environments.
  (Note: The provided input text contains execution logs and an error indicating the
  executable was not found, rather than standard help documentation.)\n\nTool homepage:
  https://metacpan.org/dist/Test-RequiresInternet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-requiresinternet:0.05--pl526_0
stdout: perl-test-requiresinternet.out
