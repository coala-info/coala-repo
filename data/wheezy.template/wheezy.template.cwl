cwlVersion: v1.2
class: CommandLineTool
baseCommand: wheezy.template
label: wheezy.template
doc: "A fast, lightweight and flexible template engine.\n\nTool homepage: https://bitbucket.org/akorn/wheezy.template"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wheezy.template:3.2.4--pyhdfd78af_0
stdout: wheezy.template.out
