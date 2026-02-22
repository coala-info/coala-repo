cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-digest-hmac
label: perl-digest-hmac
doc: "A Perl module that calculates HMAC-SHA1 and HMAC-MD5 digests. Note: The provided
  text contains system error logs regarding container execution and disk space rather
  than command-line help documentation.\n\nTool homepage: https://metacpan.org/pod/Digest-HMAC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-digest-hmac:1.05--pl5321hdfd78af_0
stdout: perl-digest-hmac.out
