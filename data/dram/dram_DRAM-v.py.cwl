cwlVersion: v1.2
class: CommandLineTool
baseCommand: dram_DRAM-v.py
label: dram_DRAM-v.py
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error indicating a failure to build a container
  image due to lack of disk space.\n\nTool homepage: https://github.com/shafferm/DRAM/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dram:1.5.0--pyhdfd78af_0
stdout: dram_DRAM-v.py.out
