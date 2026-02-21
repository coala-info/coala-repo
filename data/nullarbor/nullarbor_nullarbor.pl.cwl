cwlVersion: v1.2
class: CommandLineTool
baseCommand: nullarbor.pl
label: nullarbor_nullarbor.pl
doc: "The provided text is an error log indicating a failure to initialize the container
  environment (no space left on device) and does not contain help documentation or
  argument definitions.\n\nTool homepage: https://github.com/tseemann/nullarbor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nullarbor:2.0.20191013--0
stdout: nullarbor_nullarbor.pl.out
