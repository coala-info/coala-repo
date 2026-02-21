cwlVersion: v1.2
class: CommandLineTool
baseCommand: fluff
label: biofluff_fluff
doc: "A tool for NGS data visualization (Note: The provided text is a Python traceback/error
  log and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/simonvh/fluff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biofluff:3.0.4--pyhdfd78af_1
stdout: biofluff_fluff.out
