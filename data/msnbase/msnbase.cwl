cwlVersion: v1.2
class: CommandLineTool
baseCommand: msnbase
label: msnbase
doc: "MSnbase: Base Functions and Classes for Mass Spectrometry and Proteomics\n\n
  Tool homepage: https://github.com/lgatto/MSnbase"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/msnbase:phenomenal-v2.2_cv1.0.64
stdout: msnbase.out
