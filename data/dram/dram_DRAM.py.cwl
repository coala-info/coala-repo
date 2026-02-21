cwlVersion: v1.2
class: CommandLineTool
baseCommand: DRAM.py
label: dram_DRAM.py
doc: "Distilled and Ranked Analysis of Metabolism (DRAM)\n\nTool homepage: https://github.com/shafferm/DRAM/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dram:1.5.0--pyhdfd78af_0
stdout: dram_DRAM.py.out
