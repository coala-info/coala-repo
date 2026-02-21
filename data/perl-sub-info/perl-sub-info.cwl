cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sub-info
label: perl-sub-info
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed execution attempt where the executable
  was not found.\n\nTool homepage: http://metacpan.org/pod/Sub::Info"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sub-info:0.002--pl526_0
stdout: perl-sub-info.out
