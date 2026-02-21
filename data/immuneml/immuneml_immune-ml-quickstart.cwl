cwlVersion: v1.2
class: CommandLineTool
baseCommand: immune-ml-quickstart
label: immuneml_immune-ml-quickstart
doc: "ImmuneML quickstart tool (Note: The provided help text contains only system
  error messages and no argument definitions).\n\nTool homepage: https://github.com/uio-bmi/immuneML"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/immuneml:3.0.17--pyhdfd78af_0
stdout: immuneml_immune-ml-quickstart.out
