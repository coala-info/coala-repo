cwlVersion: v1.2
class: CommandLineTool
baseCommand: squeegee
label: squeegee
doc: "A tool for processing or cleaning data (Note: The provided text contains container
  build logs rather than CLI help documentation, so specific arguments could not be
  extracted).\n\nTool homepage: https://gitlab.com/treangenlab/squeegee"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/squeegee:0.2.0--hdfd78af_0
stdout: squeegee.out
