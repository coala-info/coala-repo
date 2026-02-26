cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pydamage
  - filter
label: pydamage_filter
doc: "Filter PyDamage results on predicted accuracy and qvalue thresholds.\n\nTool
  homepage: https://github.com/maxibor/pydamage"
inputs:
  - id: csv
    type: File
    doc: path to PyDamage result file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydamage:1.0--pyhdfd78af_0
stdout: pydamage_filter.out
