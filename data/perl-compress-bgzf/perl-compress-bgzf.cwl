cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-compress-bgzf
label: perl-compress-bgzf
doc: "A tool for BGZF (Blocked GNU Zip Format) compression, typically used in bioinformatics
  for indexing large compressed files.\n\nTool homepage: http://metacpan.org/pod/Compress::BGZF"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-compress-bgzf:0.005--pl526_0
stdout: perl-compress-bgzf.out
