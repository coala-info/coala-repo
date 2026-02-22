cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-tie-hash-indexed
label: perl-tie-hash-indexed
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to a failed container image
  build (no space left on device).\n\nTool homepage: https://metacpan.org/pod/Tie::Hash::Indexed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-tie-hash-indexed:0.08--pl5321h7b50bb2_4
stdout: perl-tie-hash-indexed.out
