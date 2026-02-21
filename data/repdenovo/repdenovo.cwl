cwlVersion: v1.2
class: CommandLineTool
baseCommand: repdenovo
label: repdenovo
doc: "A tool for de novo repeat discovery (Note: The provided help text contains only
  container engine error logs and no usage information).\n\nTool homepage: https://github.com/Reedwarbler/REPdenovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repdenovo:0.0.1--h26b121b_5
stdout: repdenovo.out
