cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-parent
label: perl-parent
doc: "The provided text does not contain help information for 'perl-parent'. It is
  an error log indicating that the executable was not found in the environment.\n\n
  Tool homepage: https://github.com/toddr/Razor2-Client-Agent"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-parent:0.236--pl526_1
stdout: perl-parent.out
