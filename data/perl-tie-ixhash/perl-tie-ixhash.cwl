cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-tie-ixhash
label: perl-tie-ixhash
doc: "The provided text does not contain help information. It is an error log indicating
  that the executable 'perl-tie-ixhash' was not found in the system PATH during an
  Apptainer/Singularity execution.\n\nTool homepage: https://github.com/mschout/tie-ixhash-fixedsize"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-tie-ixhash:1.23--pl526_2
stdout: perl-tie-ixhash.out
