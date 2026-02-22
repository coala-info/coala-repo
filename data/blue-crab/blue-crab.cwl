cwlVersion: v1.2
class: CommandLineTool
baseCommand: blue-crab
label: blue-crab
doc: "A tool for converting between ONT pod5 and fast5 formats (Note: The provided
  text contains error logs rather than help documentation, so arguments could not
  be extracted).\n\nTool homepage: https://github.com/Psy-Fer/blue-crab"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blue-crab:0.4.0--pyh05cac1d_1
stdout: blue-crab.out
