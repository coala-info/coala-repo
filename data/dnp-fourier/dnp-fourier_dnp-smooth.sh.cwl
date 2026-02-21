cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnp-fourier_dnp-smooth.sh
label: dnp-fourier_dnp-smooth.sh
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a failed container build (no space left on device).\n
  \nTool homepage: https://github.com/erinijapranckeviciene/dnpatterntools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnp-fourier:1.0--h503566f_6
stdout: dnp-fourier_dnp-smooth.sh.out
