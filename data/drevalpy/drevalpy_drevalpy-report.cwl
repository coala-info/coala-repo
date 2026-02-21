cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - drevalpy
  - report
label: drevalpy_drevalpy-report
doc: "A tool for generating reports using drevalpy.\n\nTool homepage: https://github.com/daisybio/drevalpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drevalpy:1.4.1--pyhdfd78af_0
stdout: drevalpy_drevalpy-report.out
