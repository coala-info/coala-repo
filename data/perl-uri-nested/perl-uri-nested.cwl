cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-uri-nested
label: perl-uri-nested
doc: "The provided text is a container build log and does not contain command-line
  help information or argument definitions for the tool.\n\nTool homepage: https://metacpan.org/release/URI-Nested/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-uri-nested:0.10--pl5321hdfd78af_0
stdout: perl-uri-nested.out
