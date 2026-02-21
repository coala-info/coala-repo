cwlVersion: v1.2
class: CommandLineTool
baseCommand: clsify_hlso
label: clsify_hlso
doc: "The provided text contains container build logs and a fatal error regarding
  disk space, but does not contain help text, usage instructions, or argument definitions
  for the tool.\n\nTool homepage: https://github.com/holtgrewe/clsify"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clsify:0.1.1--py_0
stdout: clsify_hlso.out
