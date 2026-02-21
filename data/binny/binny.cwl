cwlVersion: v1.2
class: CommandLineTool
baseCommand: binny
label: binny
doc: "A tool for binning metagenomic contigs. (Note: The provided text is a system
  error log regarding a container build failure and does not contain help documentation
  or argument definitions.)\n\nTool homepage: https://github.com/a-h-b/binny"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binny:2.2.18--pyhdfd78af_0
stdout: binny.out
