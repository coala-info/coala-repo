cwlVersion: v1.2
class: CommandLineTool
baseCommand: catch_pool.py
label: catch_pool.py
doc: "No description available in the provided text.\n\nTool homepage: https://github.com/broadinstitute/catch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/catch:1.5.2--pyhdfd78af_0
stdout: catch_pool.py.out
