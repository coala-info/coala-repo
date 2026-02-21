cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamkit_bamgroupreads.py
label: bamkit_bamgroupreads.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or run a container due to
  insufficient disk space.\n\nTool homepage: https://github.com/hall-lab/bamkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamkit:16.07.26--py_0
stdout: bamkit_bamgroupreads.py.out
