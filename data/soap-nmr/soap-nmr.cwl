cwlVersion: v1.2
class: CommandLineTool
baseCommand: soap-nmr
label: soap-nmr
doc: "A tool for Signal mOdeling for Analysis of Peaks in NMR (SOAP-NMR). Note: The
  provided text contains only container runtime error logs and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/phnmnl/container-soap-nmr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/soap-nmr:phenomenal-v1.0_cv0.4.1016
stdout: soap-nmr.out
