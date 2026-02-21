cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnp-fourier-transform.sh
label: dnp-fourier_dnp-fourier-transform.sh
doc: "A tool for performing Fourier transforms, likely in the context of Dynamic Nuclear
  Polarization (DNP) data processing.\n\nTool homepage: https://github.com/erinijapranckeviciene/dnpatterntools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnp-fourier:1.0--h503566f_6
stdout: dnp-fourier_dnp-fourier-transform.sh.out
