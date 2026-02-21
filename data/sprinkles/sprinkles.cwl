cwlVersion: v1.2
class: CommandLineTool
baseCommand: sprinkles
label: sprinkles
doc: "The provided text does not contain help information or a description for the
  tool 'sprinkles'. It appears to be an error log from a container build process.\n
  \nTool homepage: https://github.com/sprinkle-tool/sprinkle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sprinkles:0.4.6--py35_1
stdout: sprinkles.out
