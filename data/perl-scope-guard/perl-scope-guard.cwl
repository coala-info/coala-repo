cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-scope-guard
label: perl-scope-guard
doc: "The provided text does not contain help documentation or usage instructions.
  It appears to be an error log from a container execution environment indicating
  that the executable 'perl-scope-guard' was not found in the system PATH.\n\nTool
  homepage: https://github.com/pld-linux/perl-Scope-Guard"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-scope-guard:0.21--0
stdout: perl-scope-guard.out
