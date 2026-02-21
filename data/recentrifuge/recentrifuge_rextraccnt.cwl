cwlVersion: v1.2
class: CommandLineTool
baseCommand: rextraccnt
label: recentrifuge_rextraccnt
doc: "A tool within the Recentrifuge package. (Note: The provided text contains container
  runtime error logs rather than the tool's help documentation, so no arguments could
  be extracted.)\n\nTool homepage: https://github.com/khyox/recentrifuge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recentrifuge:2.0.0--pyhdfd78af_0
stdout: recentrifuge_rextraccnt.out
