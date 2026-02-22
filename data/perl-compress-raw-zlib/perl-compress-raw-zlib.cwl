cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-compress-raw-zlib
label: perl-compress-raw-zlib
doc: "Low-level interface to zlib compression library. Note: The provided text contains
  system error messages regarding container image pulling and does not contain CLI
  help documentation.\n\nTool homepage: http://metacpan.org/pod/Compress::Raw::Zlib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-compress-raw-zlib:2.105--pl5321h87f3376_0
stdout: perl-compress-raw-zlib.out
