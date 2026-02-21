cwlVersion: v1.2
class: CommandLineTool
baseCommand: spectra_spectral
label: spectra_spectral
doc: "A tool for spectral analysis. (Note: The provided text contains container build
  logs and error messages rather than CLI help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/stoplightio/spectral"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/spectra:v0.0.11-1-deb-py3_cv1
stdout: spectra_spectral.out
