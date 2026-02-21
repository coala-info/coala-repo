cwlVersion: v1.2
class: CommandLineTool
baseCommand: gait-gm_add_pval_flags
label: gait-gm_add_pval_flags
doc: "Add p-value flags (Note: The provided text contains container runtime error
  messages and does not include the tool's help documentation or usage instructions).\n
  \nTool homepage: https://github.com/secimTools/gait-gm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
stdout: gait-gm_add_pval_flags.out
