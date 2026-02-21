cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtv-cli
label: wtv_wtv-cli
doc: "Whole Transcriptome Viewer CLI (Note: The provided text is a container execution
  log and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://recetox.github.io/wtv/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wtv:0.1.0--pyhdfd78af_0
stdout: wtv_wtv-cli.out
