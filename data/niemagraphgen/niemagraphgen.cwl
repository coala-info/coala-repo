cwlVersion: v1.2
class: CommandLineTool
baseCommand: niemagraphgen
label: niemagraphgen
doc: "The provided text is an error log indicating a container build failure (no space
  left on device) and does not contain help documentation or argument definitions
  for the tool.\n\nTool homepage: https://github.com/niemasd/NiemaGraphGen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemagraphgen:1.0.6--h503566f_1
stdout: niemagraphgen.out
