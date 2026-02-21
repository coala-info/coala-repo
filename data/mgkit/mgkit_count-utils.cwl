cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mgkit
  - count-utils
label: mgkit_count-utils
doc: "MGKit utility for processing count data. (Note: The provided help text contained
  only system error logs and no usage information.)\n\nTool homepage: https://github.com/frubino/mgkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgkit:0.5.8--py39hbcbf7aa_4
stdout: mgkit_count-utils.out
