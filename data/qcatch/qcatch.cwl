cwlVersion: v1.2
class: CommandLineTool
baseCommand: qcatch
label: qcatch
doc: "A tool for quality control and analysis (description not provided in help text).\n
  \nTool homepage: https://github.com/COMBINE-lab/QCatch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qcatch:0.2.8--pyhdfd78af_0
stdout: qcatch.out
