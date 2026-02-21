cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnp-fourier
label: dnp-fourier
doc: "The provided text contains error logs from a container runtime and does not
  include the tool's help documentation or usage instructions. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/erinijapranckeviciene/dnpatterntools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnp-fourier:1.0--h503566f_6
stdout: dnp-fourier.out
