cwlVersion: v1.2
class: CommandLineTool
baseCommand: spectra
label: spectra
doc: "The provided text does not contain help information or usage instructions for
  the tool 'spectra'. It appears to be a log of a failed container build/fetch process.\n
  \nTool homepage: https://github.com/stoplightio/spectral"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/spectra:v0.0.11-1-deb-py3_cv1
stdout: spectra.out
