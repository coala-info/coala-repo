cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-json-maybexs
label: perl-json-maybexs
doc: "JSON::MaybeXS is a Perl module that uses the best available JSON implementation
  (JSON::XS, Cpanel::JSON::XS, or JSON::PP). Note: The provided text contains system
  error logs rather than tool help documentation.\n\nTool homepage: http://metacpan.org/pod/JSON::MaybeXS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-json-maybexs:1.004003--pl5321hdfd78af_0
stdout: perl-json-maybexs.out
