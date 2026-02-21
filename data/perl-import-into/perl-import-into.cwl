cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-import-into
label: perl-import-into
doc: "The provided text does not contain help documentation for the tool. It appears
  to be a log of a failed execution where the executable was not found.\n\nTool homepage:
  http://metacpan.org/pod/Import::Into"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-import-into:1.002005--pl526_0
stdout: perl-import-into.out
