cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-libwww-perl
label: perl-libwww-perl
doc: "The libwww-perl (LWP) collection is a set of Perl modules which provides a simple
  and consistent application programming interface to the World-Wide Web. (Note: The
  provided text appears to be a system error log regarding container image retrieval
  rather than CLI help text; therefore, no arguments could be extracted.)\n\nTool
  homepage: https://metacpan.org/pod/HTTP::CookieJar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-libwww-perl:6.81--pl5321hdfd78af_0
stdout: perl-libwww-perl.out
