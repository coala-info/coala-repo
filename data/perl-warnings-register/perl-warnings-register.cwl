cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-warnings-register
label: perl-warnings-register
doc: "The provided text does not contain help documentation for the tool. It is an
  error log indicating that the executable was not found in the system path.\n\nTool
  homepage: https://github.com/kousetuka08/Yoki"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-warnings-register:1.03--pl5.22.0_0
stdout: perl-warnings-register.out
