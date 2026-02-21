cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run_tasmanian
label: tasmanian-mismatch_run_tasmanian
doc: "Tasmanian-mismatch tool (Help text provided contains only system logs and no
  usage information).\n\nTool homepage: https://github.com/nebiolabs/tasmanian-mismatch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tasmanian-mismatch:1.0.9--pyhdfd78af_0
stdout: tasmanian-mismatch_run_tasmanian.out
