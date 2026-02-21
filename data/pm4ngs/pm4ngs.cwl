cwlVersion: v1.2
class: CommandLineTool
baseCommand: pm4ngs
label: pm4ngs
doc: "pm4ngs is a tool for managing Next-Generation Sequencing (NGS) projects. (Note:
  The provided text appears to be a container build log rather than CLI help text;
  no arguments could be extracted from the input.)\n\nTool homepage: https://pypi.org/project/pm4ngs/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pm4ngs:0.1.3--pyhdfd78af_0
stdout: pm4ngs.out
