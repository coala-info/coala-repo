cwlVersion: v1.2
class: CommandLineTool
baseCommand: covid-spike-classification
label: covid-spike-classification
doc: "A tool for COVID spike protein classification (Note: The provided text is a
  container build error log and does not contain usage instructions or argument definitions).\n
  \nTool homepage: https://github.com/kblin/covid-spike-classification/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/covid-spike-classification:0.6.4--pyhdfd78af_0
stdout: covid-spike-classification.out
