cwlVersion: v1.2
class: CommandLineTool
baseCommand: zalign
label: zalign
doc: "A tool for local sequence alignment (Note: The provided text contains container
  execution logs rather than help documentation; no arguments could be extracted).\n
  \nTool homepage: https://github.com/Zuehlke/ZAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/zalign:v0.9.1-4-deb_cv1
stdout: zalign.out
