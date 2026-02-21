cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-mlst-check
label: perl-bio-mlst-check
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a failed container build/extraction (no space left on
  device).\n\nTool homepage: http://www.sanger.ac.uk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-mlst-check:2.1.1706216--pl526_1
stdout: perl-bio-mlst-check.out
