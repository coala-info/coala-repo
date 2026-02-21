cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-term-encoding
label: perl-term-encoding
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating that the executable 'perl-term-encoding' was not found in the system
  PATH during a container build process.\n\nTool homepage: http://metacpan.org/pod/Term::Encoding"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-term-encoding:0.03--pl526_0
stdout: perl-term-encoding.out
