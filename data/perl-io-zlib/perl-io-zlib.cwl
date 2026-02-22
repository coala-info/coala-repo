cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-zlib
label: perl-io-zlib
doc: "IO::Zlib provides an IO:: style interface to Compress::Zlib. Note: The provided
  text contains system error messages regarding container image extraction and does
  not contain CLI help documentation.\n\nTool homepage: https://metacpan.org/pod/IO::Zlib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-zlib:1.15--pl5321hdfd78af_1
stdout: perl-io-zlib.out
