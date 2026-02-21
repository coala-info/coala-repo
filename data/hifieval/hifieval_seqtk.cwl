cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hifieval
  - seqtk
label: hifieval_seqtk
doc: "A tool within the hifieval suite (Note: The provided help text contains only
  container runtime error messages and no usage information).\n\nTool homepage: https://github.com/magspho/hifieval"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifieval:0.4.0--pyh7cba7a3_0
stdout: hifieval_seqtk.out
