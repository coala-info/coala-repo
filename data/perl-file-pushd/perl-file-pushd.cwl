cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-pushd
label: perl-file-pushd
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating that the executable was not found in the environment.\n\nTool homepage:
  https://github.com/dagolden/File-pushd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-pushd:1.016--pl526_0
stdout: perl-file-pushd.out
