cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-cleannamespaces
label: perl-test-cleannamespaces
doc: "A tool to check for uncleaned namespaces in Perl modules.\n\nTool homepage:
  https://github.com/karenetheridge/Test-CleanNamespaces"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-cleannamespaces:0.24--pl526_0
stdout: perl-test-cleannamespaces.out
