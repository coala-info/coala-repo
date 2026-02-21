cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-try-tiny-retry
label: perl-try-tiny-retry
doc: "A Perl tool/module for retrying code blocks (Note: The provided help text contains
  only system logs and an execution error, so no specific arguments could be extracted).\n
  \nTool homepage: https://github.com/dagolden/Try-Tiny-Retry"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-try-tiny-retry:0.004--pl526_0
stdout: perl-try-tiny-retry.out
