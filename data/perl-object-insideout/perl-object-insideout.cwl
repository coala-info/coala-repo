cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-object-insideout
label: perl-object-insideout
doc: "The executable 'perl-object-insideout' was not found in the system path. No
  help text or usage information was available to parse.\n\nTool homepage: http://metacpan.org/pod/Object::InsideOut"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-object-insideout:4.05--pl526_0
stdout: perl-object-insideout.out
