cwlVersion: v1.2
class: CommandLineTool
baseCommand: catch_design.py
label: catch_design.py
doc: "No description available: The provided text is a system error log regarding
  container construction, not help text.\n\nTool homepage: https://github.com/broadinstitute/catch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/catch:1.5.2--pyhdfd78af_0
stdout: catch_design.py.out
