cwlVersion: v1.2
class: CommandLineTool
baseCommand: formulaic-contrasts
label: formulaic-contrasts
doc: "A tool for generating contrast matrices from formulas (Note: The provided help
  text contains only container runtime error messages and no usage information).\n
  \nTool homepage: https://github.com/scverse/formulaic-contrasts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/formulaic-contrasts:1.0.0--pyhdfd78af_0
stdout: formulaic-contrasts.out
