cwlVersion: v1.2
class: CommandLineTool
baseCommand: DRAM
label: dram
doc: "Distilled and Refined Annotation of Metabolism (Note: The provided help text
  contains only container runtime error messages and no usage information).\n\nTool
  homepage: https://github.com/shafferm/DRAM/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dram:1.5.0--pyhdfd78af_0
stdout: dram.out
