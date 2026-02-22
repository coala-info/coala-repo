cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-mozilla-ca
label: perl-mozilla-ca
doc: "Mozilla's CA cert bundle in PEM format. (Note: The provided text contains system
  error logs regarding disk space and container image retrieval rather than command-line
  help documentation.)\n\nTool homepage: https://metacpan.org/pod/Mozilla::CA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-mozilla-ca:20250602--pl5321hdfd78af_0
stdout: perl-mozilla-ca.out
