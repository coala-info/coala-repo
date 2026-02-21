cwlVersion: v1.2
class: CommandLineTool
baseCommand: sample_grouping
label: sample_grouping
doc: "A tool for sample grouping. (Note: The provided text appears to be a container
  engine log rather than CLI help text, so no arguments could be extracted.)\n\nTool
  homepage: https://github.com/SantaMcCloud/Sample_grouping"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sample_grouping:1.0.0--pyhdfd78af_0
stdout: sample_grouping.out
