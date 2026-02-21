cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacache
label: metacache
doc: "Metagenomic classification and profiling tool (Note: The provided text contains
  only system error logs and no help information; therefore, no arguments could be
  extracted).\n\nTool homepage: https://github.com/muellan/metacache"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
stdout: metacache.out
