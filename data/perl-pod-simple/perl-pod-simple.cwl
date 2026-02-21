cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pod-simple
label: perl-pod-simple
doc: "The provided text does not contain help documentation. It is a system log indicating
  a fatal error where the executable 'perl-pod-simple' was not found in the environment's
  PATH.\n\nTool homepage: https://github.com/perl-pod/pod-simple"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pod-simple:3.35--pl5.22.0_0
stdout: perl-pod-simple.out
