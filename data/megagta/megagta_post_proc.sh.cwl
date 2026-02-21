cwlVersion: v1.2
class: CommandLineTool
baseCommand: megagta_post_proc.sh
label: megagta_post_proc.sh
doc: "Post-processing script for MegaGTA (Note: The provided help text contains only
  system error logs and no usage information).\n\nTool homepage: https://github.com/HKU-BAL/MegaGTA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megagta:0.1_alpha--0
stdout: megagta_post_proc.sh.out
