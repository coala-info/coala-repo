cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-digest-crc32
label: perl-digest-crc32
doc: "A tool for calculating CRC32 checksums. (Note: The provided help text contains
  only system logs and a fatal error indicating the executable was not found in the
  environment, so no arguments could be extracted.)\n\nTool homepage: https://github.com/aur-archive/perl-digest-crc32"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-digest-crc32:0.01--pl526_1
stdout: perl-digest-crc32.out
