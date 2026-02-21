cwlVersion: v1.2
class: CommandLineTool
baseCommand: hifieval
label: hifieval
doc: "The provided text does not contain help documentation or usage instructions.
  It contains container runtime error messages indicating a failure to pull or run
  the hifieval image due to lack of disk space.\n\nTool homepage: https://github.com/magspho/hifieval"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifieval:0.4.0--pyh7cba7a3_0
stdout: hifieval.out
