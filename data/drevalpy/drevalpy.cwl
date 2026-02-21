cwlVersion: v1.2
class: CommandLineTool
baseCommand: drevalpy
label: drevalpy
doc: "A tool for evaluation (detailed description and arguments not available in the
  provided help text)\n\nTool homepage: https://github.com/daisybio/drevalpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drevalpy:1.4.1--pyhdfd78af_0
stdout: drevalpy.out
