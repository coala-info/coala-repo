cwlVersion: v1.2
class: CommandLineTool
baseCommand: thapbi-pict
label: thapbi-pict
doc: "The provided text contains container build logs and error messages rather than
  the tool's help documentation. No arguments or descriptions could be extracted from
  the input.\n\nTool homepage: https://github.com/peterjc/thapbi-pict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
stdout: thapbi-pict.out
