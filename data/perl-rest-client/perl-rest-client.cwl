cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-rest-client
label: perl-rest-client
doc: "Perl extension for RESTful web services. (Note: The provided text contains system
  error messages regarding container execution and disk space rather than CLI help
  documentation; therefore, no arguments could be extracted.)\n\nTool homepage: http://metacpan.org/pod/REST::Client"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-rest-client:281--hdfd78af_0
stdout: perl-rest-client.out
