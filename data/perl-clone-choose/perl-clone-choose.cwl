cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-clone-choose
label: perl-clone-choose
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating that the executable was not found in the environment.\n\nTool homepage:
  https://metacpan.org/release/Clone-Choose"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-clone-choose:0.010--pl526_0
stdout: perl-clone-choose.out
