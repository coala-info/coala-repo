cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-tie-toobject
label: perl-tie-toobject
doc: "Tie to an existing object (Note: The provided text is an execution error log
  and does not contain help documentation or argument definitions).\n\nTool homepage:
  http://metacpan.org/pod/Tie::ToObject"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-tie-toobject:0.03--pl526_1
stdout: perl-tie-toobject.out
