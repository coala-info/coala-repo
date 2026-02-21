cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bart
  - profile
label: bart_bart-profile
doc: "The provided text is an error log indicating a system failure (no space left
  on device) during a container build and does not contain help documentation or argument
  definitions.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bart:0.1.2--pyhdfd78af_0
stdout: bart_bart-profile.out
