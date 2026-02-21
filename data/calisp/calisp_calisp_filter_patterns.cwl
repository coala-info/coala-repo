cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - calisp
  - filter_patterns
label: calisp_calisp_filter_patterns
doc: "The provided text is an error log indicating a system failure (no space left
  on device) during a container build and does not contain help information for the
  tool.\n\nTool homepage: https://github.com/kinestetika/Calisp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/calisp:3.1.4--pyhdfd78af_0
stdout: calisp_calisp_filter_patterns.out
