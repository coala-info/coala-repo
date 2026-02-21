cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sereal-decoder
label: perl-sereal-decoder
doc: "The provided text does not contain help information for the tool; it is a system
  error log describing a failed container build due to insufficient disk space.\n\n
  Tool homepage: https://metacpan.org/pod/Sereal::Decoder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sereal-decoder:5.004--pl5321h7b50bb2_0
stdout: perl-sereal-decoder.out
