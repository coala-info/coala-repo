cwlVersion: v1.2
class: CommandLineTool
baseCommand: mypmfs_py
label: mypmfs_py
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run a container due to insufficient disk space.\n
  \nTool homepage: https://github.com/bibip-impmc/mypmfs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mypmfs_py:0.1.8--pyhdfd78af_0
stdout: mypmfs_py.out
