cwlVersion: v1.2
class: CommandLineTool
baseCommand: fftw
label: fftw
doc: "FFTW is a C subroutine library for computing the discrete Fourier transform
  (DFT) in one or more dimensions. (Note: The provided text is an error log and does
  not contain usage information.)\n\nTool homepage: https://github.com/FFTW/fftw3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fftw:3.3.4--0
stdout: fftw.out
