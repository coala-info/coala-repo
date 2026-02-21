cwlVersion: v1.2
class: CommandLineTool
baseCommand: mypmfs_py_scoring
label: mypmfs_py_scoring
doc: "A tool for scoring (description unavailable as the provided text contains container
  runtime error logs instead of help documentation).\n\nTool homepage: https://github.com/bibip-impmc/mypmfs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mypmfs_py:0.1.8--pyhdfd78af_0
stdout: mypmfs_py_scoring.out
