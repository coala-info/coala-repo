cwlVersion: v1.2
class: CommandLineTool
baseCommand: parm
label: parm
doc: "A tool for processing or analyzing data (description not available in provided
  text)\n\nTool homepage: https://github.com/vansteensellab/PARM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parm:0.1.44--pyh7e72e81_0
stdout: parm.out
