cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sprinkles
  - sprinkle
label: sprinkles_sprinkle
doc: "The provided text does not contain a description or usage information for the
  tool, as it appears to be a container build log error.\n\nTool homepage: https://github.com/sprinkle-tool/sprinkle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sprinkles:0.4.6--py35_1
stdout: sprinkles_sprinkle.out
