cwlVersion: v1.2
class: CommandLineTool
baseCommand: tiptoft
label: tiptoft
doc: "A tool for predicting plasmids from bacterial assemblies (Note: The provided
  text appears to be a container build error log rather than CLI help text; therefore,
  no arguments could be extracted).\n\nTool homepage: https://github.com/andrewjpage/tiptoft"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tiptoft:1.0.2--py310h4b81fae_4
stdout: tiptoft.out
