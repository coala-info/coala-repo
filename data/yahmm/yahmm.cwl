cwlVersion: v1.2
class: CommandLineTool
baseCommand: yahmm
label: yahmm
doc: "Yet Another Hidden Markov Model (yahmm) tool. (Note: The provided text contains
  system logs and a fatal error rather than the tool's help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/jmschrei/yahmm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yahmm:1.1.3--py310h1fe012e_11
stdout: yahmm.out
