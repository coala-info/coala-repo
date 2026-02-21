cwlVersion: v1.2
class: CommandLineTool
baseCommand: graftm
label: graftm
doc: "GraftM is a tool for finding and classifying sequences in metagenomic data.
  (Note: The provided input text contains system error messages regarding a container
  runtime failure and does not contain the actual help documentation or argument list
  for the tool.)\n\nTool homepage: http://geronimp.github.io/graftM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graftm:0.15.1--pyhdfd78af_0
stdout: graftm.out
