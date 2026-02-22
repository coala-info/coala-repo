cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-digest-crc
label: perl-digest-crc
doc: "A Perl extension for calculating Cyclic Redundancy Check (CRC) digests. (Note:
  The provided text contains system error messages rather than help documentation;
  no arguments could be extracted.)\n\nTool homepage: http://metacpan.org/pod/Digest::CRC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-digest-crc:0.23--pl5321h7b50bb2_5
stdout: perl-digest-crc.out
