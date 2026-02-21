cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-test-sys-info
label: perl-test-sys-info
doc: "A tool for testing system information. Note: The provided input contains execution
  logs indicating the executable was not found, rather than standard help text; therefore,
  no specific arguments could be extracted.\n\nTool homepage: http://metacpan.org/pod/Test::Sys::Info"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-sys-info:0.23--pl526_0
stdout: perl-test-sys-info.out
