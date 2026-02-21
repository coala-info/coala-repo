cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sereal-encoder
label: perl-sereal-encoder
doc: "Sereal is an efficient, compact-binary data serialization format. The encoder
  part of the Sereal implementation.\n\nTool homepage: https://metacpan.org/pod/Sereal::Encoder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sereal-encoder:5.004--pl5321h7b50bb2_0
stdout: perl-sereal-encoder.out
