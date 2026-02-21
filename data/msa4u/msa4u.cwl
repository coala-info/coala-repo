cwlVersion: v1.2
class: CommandLineTool
baseCommand: msa4u
label: msa4u
doc: "A tool for Multiple Sequence Alignment (Note: The provided text is a container
  execution error log and does not contain help documentation or argument definitions).\n
  \nTool homepage: https://github.com/GCA-VH-lab/msa4u"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msa4u:0.4.0--pyh7e72e81_0
stdout: msa4u.out
