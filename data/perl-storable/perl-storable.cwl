cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-storable
label: perl-storable
doc: "A tool related to Perl's Storable module (Note: The provided text is an error
  log indicating the executable was not found, so no specific help information or
  arguments could be extracted).\n\nTool homepage: http://metacpan.org/pod/Storable"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-storable:3.15--pl526h14c3975_0
stdout: perl-storable.out
