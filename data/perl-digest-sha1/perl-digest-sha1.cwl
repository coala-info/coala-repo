cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-digest-sha1
label: perl-digest-sha1
doc: "Perl interface to the SHA-1 algorithm. Note: The provided text contains system
  error messages regarding disk space and container image retrieval rather than command-line
  help documentation.\n\nTool homepage: http://metacpan.org/pod/Digest::SHA1"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-digest-sha1:2.13--pl5321h9948957_8
stdout: perl-digest-sha1.out
