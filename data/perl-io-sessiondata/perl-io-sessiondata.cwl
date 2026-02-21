cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-sessiondata
label: perl-io-sessiondata
doc: "A Perl module/tool for session data I/O. (Note: The provided text is an execution
  log indicating a failure to find the executable and does not contain usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/pld-linux/perl-IO-SessionData"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-sessiondata:1.03--pl526_1
stdout: perl-io-sessiondata.out
