cwlVersion: v1.2
class: CommandLineTool
baseCommand: transrate-tools
label: transrate-tools
doc: "The provided text is an error log indicating a failure to build or extract the
  container image (no space left on device) and does not contain help documentation
  or argument definitions for the tool.\n\nTool homepage: https://github.com/blahah/transrate-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/transrate-tools:v1.0.0-2-deb_cv1
stdout: transrate-tools.out
