cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-proc-fork
label: perl-proc-fork
doc: "The perl-proc-fork executable (Note: The provided text is an error log indicating
  the executable was not found, rather than help text; therefore, no arguments could
  be extracted).\n\nTool homepage: http://github.com/ap/Proc-Fork"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-proc-fork:0.806--pl526_0
stdout: perl-proc-fork.out
