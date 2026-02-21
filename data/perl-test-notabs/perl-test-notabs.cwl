cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-notabs
label: perl-test-notabs
doc: "A tool to check for hard tabs in files (Note: The provided help text contains
  only execution logs and an error indicating the executable was not found; no specific
  arguments could be parsed from the input).\n\nTool homepage: http://metacpan.org/pod/Test-NoTabs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-notabs:2.02--pl526_0
stdout: perl-test-notabs.out
