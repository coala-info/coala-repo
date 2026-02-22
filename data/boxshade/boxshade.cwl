cwlVersion: v1.2
class: CommandLineTool
baseCommand: boxshade
label: boxshade
doc: "A program for creating good looking printouts from multiple-aligned sequences.
  (Note: The provided input text contains system error messages regarding disk space
  and does not contain help documentation; no arguments could be parsed from the source
  text.)\n\nTool homepage: https://github.com/mdbaron42/pyBoxshade"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/boxshade:v3.3.1-12-deb_cv1
stdout: boxshade.out
