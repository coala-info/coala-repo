cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda-script_est_depth
label: igda-script_est_depth
doc: "Estimation of depth (Note: The provided text contains container runtime error
  messages and does not include the actual help documentation for the tool.)\n\nTool
  homepage: https://github.com/zhixingfeng/shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_est_depth.out
