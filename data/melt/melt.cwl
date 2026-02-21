cwlVersion: v1.2
class: CommandLineTool
baseCommand: melt
label: melt
doc: "Mobile Element Locator Tool (MELT)\n\nTool homepage: https://github.com/meltylabs/melty"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/melt:1.0.3--py35_1
stdout: melt.out
