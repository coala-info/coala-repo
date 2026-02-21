cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux
label: crux
doc: "Crux is a software toolkit for tandem mass spectrometry analysis. (Note: The
  provided input text was a container execution log showing a 'no space left on device'
  error rather than help text; this definition is based on the tool name hint).\n\n
  Tool homepage: https://github.com/redbadger/crux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux.out
