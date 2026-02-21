cwlVersion: v1.2
class: CommandLineTool
baseCommand: sierra-local
label: sierra-local
doc: "A tool for local execution of the Sierra HIV drug resistance database (Note:
  The provided text contains container build logs rather than tool help text; no arguments
  could be extracted).\n\nTool homepage: https://github.com/PoonLab/sierra-local"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sierra-local:0.4.3--py310hdfd78af_0
stdout: sierra-local.out
