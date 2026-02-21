cwlVersion: v1.2
class: CommandLineTool
baseCommand: dendropy
label: dendropy
doc: "The provided text is an error message indicating a failure to build or run the
  container image due to insufficient disk space, rather than CLI help text. No arguments
  or tool descriptions could be extracted.\n\nTool homepage: https://github.com/jeetsukumaran/DendroPy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dendropy:5.0.8--pyhdfd78af_1
stdout: dendropy.out
