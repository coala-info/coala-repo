cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdeval
label: rdeval
doc: "A tool for read evaluation (Note: The provided text is a container build error
  log and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/vgl-hub/rdeval"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdeval:0.0.8--r44h35c04b2_1
stdout: rdeval.out
