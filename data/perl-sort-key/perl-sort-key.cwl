cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sort-key
label: perl-sort-key
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: http://metacpan.org/pod/Sort-Key"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sort-key:1.33--pl5321hec16e2b_3
stdout: perl-sort-key.out
