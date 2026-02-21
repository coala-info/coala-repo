cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-devel-stacktrace
label: perl-devel-stacktrace
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log from a container build process that ended in a fatal error indicating
  the executable was not found.\n\nTool homepage: http://metacpan.org/release/Devel-StackTrace"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-devel-stacktrace:2.04--pl526_0
stdout: perl-devel-stacktrace.out
