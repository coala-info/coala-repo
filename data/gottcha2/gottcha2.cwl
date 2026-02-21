cwlVersion: v1.2
class: CommandLineTool
baseCommand: gottcha2
label: gottcha2
doc: "GOTTCHA2 is a taxonomic profiling tool. (Note: The provided help text contains
  only container runtime error messages and no usage information; arguments could
  not be extracted from the input.)\n\nTool homepage: https://github.com/poeli/gottcha2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gottcha2:2.1.10--pyhdfd78af_0
stdout: gottcha2.out
