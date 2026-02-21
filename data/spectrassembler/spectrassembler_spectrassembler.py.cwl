cwlVersion: v1.2
class: CommandLineTool
baseCommand: spectrassembler_spectrassembler.py
label: spectrassembler_spectrassembler.py
doc: "SpectrAssembler: A tool for assembling spectra (Note: The provided text contains
  container build logs rather than tool help text, so arguments could not be extracted).\n
  \nTool homepage: https://github.com/antrec/spectrassembler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spectrassembler:0.0.1a1--py27_1
stdout: spectrassembler_spectrassembler.py.out
