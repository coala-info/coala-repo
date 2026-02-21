cwlVersion: v1.2
class: CommandLineTool
baseCommand: emerald
label: emerald
doc: "Emerald (Note: The provided text is an error log from a container runtime and
  does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/algbio/emerald"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emerald:1.2.1--hd2a2fb8_2
stdout: emerald.out
