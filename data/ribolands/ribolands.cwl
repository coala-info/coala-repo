cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribolands
label: ribolands
doc: "A tool for analyzing RNA folding landscapes (Note: The provided text is a container
  build error log and does not contain CLI help information).\n\nTool homepage: https://github.com/bad-ants-fleet/ribolands"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribolands:0.6.1--py_0
stdout: ribolands.out
