cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sub-uplevel
label: perl-sub-uplevel
doc: "The provided text does not contain help documentation or usage instructions.
  It is a log of a failed execution attempt indicating that the executable 'perl-sub-uplevel'
  was not found in the system path.\n\nTool homepage: https://github.com/dagolden/Sub-Uplevel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sub-uplevel:0.2800--pl526h470a237_0
stdout: perl-sub-uplevel.out
