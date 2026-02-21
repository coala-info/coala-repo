cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-env
label: perl-env
doc: "The provided text does not contain help information for perl-env; it is a log
  showing a failed execution where the executable was not found in the system PATH.\n
  \nTool homepage: http://search.cpan.org/dist/Env"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-env:1.04--pl526_0
stdout: perl-env.out
