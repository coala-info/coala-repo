cwlVersion: v1.2
class: CommandLineTool
baseCommand: scxmatch
label: scxmatch
doc: "A tool for single-cell cross-matching (Note: The provided text is an error log
  from a container build process and does not contain help documentation or argument
  definitions).\n\nTool homepage: https://github.com/bionetslab/scxmatch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scxmatch:0.1.1--pyhdfd78af_0
stdout: scxmatch.out
