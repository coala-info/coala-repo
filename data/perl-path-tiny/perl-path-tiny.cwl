cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-path-tiny
label: perl-path-tiny
doc: "The provided text does not contain help information or a description for the
  tool; it contains error messages related to a failed container image pull (no space
  left on device).\n\nTool homepage: https://github.com/dagolden/Path-Tiny"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-path-tiny:0.122--pl5321hdfd78af_0
stdout: perl-path-tiny.out
