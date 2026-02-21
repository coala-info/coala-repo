cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-archive-tar-wrapper
label: perl-archive-tar-wrapper
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating that the executable was not found in the environment.\n\nTool homepage:
  http://metacpan.org/pod/Archive::Tar::Wrapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-archive-tar-wrapper:0.33--pl526_0
stdout: perl-archive-tar-wrapper.out
