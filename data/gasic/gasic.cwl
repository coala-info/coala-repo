cwlVersion: v1.2
class: CommandLineTool
baseCommand: gasic
label: gasic
doc: "Genome Abundance Similarity Correction (Note: The provided text is a container
  execution error log and does not contain help documentation or argument definitions).\n
  \nTool homepage: https://github.com/steveyegge/gastown"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gasic:v0.0.r19-4-deb_cv1
stdout: gasic.out
