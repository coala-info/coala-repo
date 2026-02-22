cwlVersion: v1.2
class: CommandLineTool
baseCommand: praat
label: praat
doc: "Praat is a free computer software package for the scientific analysis of speech
  in phonetics.\n\nTool homepage: https://github.com/praat/praat.github.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/praat:v6.0.48-1-deb_cv1
stdout: praat.out
