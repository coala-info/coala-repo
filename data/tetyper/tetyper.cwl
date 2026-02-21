cwlVersion: v1.2
class: CommandLineTool
baseCommand: tetyper
label: tetyper
doc: "TETyper: a tool for the analysis of transposable elements and their flanking
  regions. (Note: The provided text appears to be a container build error log rather
  than CLI help text; no arguments could be extracted from the input.)\n\nTool homepage:
  https://github.com/aesheppard/TETyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tetyper:1.1--0
stdout: tetyper.out
