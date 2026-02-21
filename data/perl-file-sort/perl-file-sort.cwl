cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-sort
label: perl-file-sort
doc: "The provided text does not contain help information as the executable was not
  found in the environment. No arguments could be parsed.\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-sort:1.01--pl526_2
stdout: perl-file-sort.out
