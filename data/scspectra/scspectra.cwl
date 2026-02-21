cwlVersion: v1.2
class: CommandLineTool
baseCommand: scspectra
label: scspectra
doc: "scspectra (Note: The provided text is a container build error log and does not
  contain CLI help information or argument definitions.)\n\nTool homepage: https://github.com/dpeerlab/spectra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scspectra:0.2.1--pyhdfd78af_0
stdout: scspectra.out
