cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-devel-globaldestruction
label: perl-devel-globaldestruction
doc: "The provided text does not contain help documentation. It appears to be a system
  log indicating a failed execution attempt where the executable 'perl-devel-globaldestruction'
  was not found in the PATH.\n\nTool homepage: https://metacpan.org/release/Devel-GlobalDestruction"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-devel-globaldestruction:0.14--pl526_0
stdout: perl-devel-globaldestruction.out
