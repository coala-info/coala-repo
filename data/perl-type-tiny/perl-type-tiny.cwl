cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-type-tiny
label: perl-type-tiny
doc: "The provided text is a system error log regarding a failed container build (no
  space left on device) and does not contain help information or usage instructions
  for the tool.\n\nTool homepage: https://metacpan.org/release/Type-Tiny"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-type-tiny:1.016006--pl5321hdfd78af_0
stdout: perl-type-tiny.out
