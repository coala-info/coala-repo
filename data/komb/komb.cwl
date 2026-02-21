cwlVersion: v1.2
class: CommandLineTool
baseCommand: komb
label: komb
doc: "The provided text does not contain help information as it is an error log indicating
  a failure to pull or run the container (no space left on device).\n\nTool homepage:
  https://gitlab.com/treangenlab/komb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/komb:1.0--py38h69e0bdc_2
stdout: komb.out
