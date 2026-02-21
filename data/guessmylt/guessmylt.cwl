cwlVersion: v1.2
class: CommandLineTool
baseCommand: guessmylt
label: guessmylt
doc: "A tool for lineage/type guessing (Note: The provided help text contains only
  container runtime error logs and does not list specific tool arguments).\n\nTool
  homepage: https://github.com/NBISweden/GUESSmyLT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/guessmylt:0.2.5--py_0
stdout: guessmylt.out
