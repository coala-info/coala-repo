cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-regexp-common
label: perl-regexp-common
doc: "The provided text does not contain help information for the tool. It appears
  to be a container execution error log indicating that the executable was not found.\n
  \nTool homepage: http://metacpan.org/pod/Regexp::Common"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-regexp-common:2017060201--pl526_0
stdout: perl-regexp-common.out
