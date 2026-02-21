cwlVersion: v1.2
class: CommandLineTool
baseCommand: updio_UPDio.pl
label: updio_UPDio.pl
doc: "A tool for Uniparental Disomy (UPD) detection. (Note: The provided text appears
  to be a container build error log rather than help text; therefore, no arguments
  could be extracted from the input.)\n\nTool homepage: https://github.com/rhpvorderman/updio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/updio:1.1.0--hdfd78af_0
stdout: updio_UPDio.pl.out
