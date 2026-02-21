cwlVersion: v1.2
class: CommandLineTool
baseCommand: polypolish
label: polypolish
doc: "Polypolish is a tool for polishing genome assemblies with short reads. (Note:
  The provided input text was a container execution error log and did not contain
  help documentation; no arguments could be parsed from the source text.)\n\nTool
  homepage: https://github.com/rrwick/Polypolish"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polypolish:0.6.1--h3ab6199_0
stdout: polypolish.out
