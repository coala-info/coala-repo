cwlVersion: v1.2
class: CommandLineTool
baseCommand: nmrmlconv
label: nmrmlconv
doc: 'A tool for converting NMR (Nuclear Magnetic Resonance) data to the nmrML format.
  Note: The provided help text contains only system error messages regarding container
  execution and does not list specific command-line arguments.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/nmrmlconv:phenomenal-v1.1b_cv0.6.55
stdout: nmrmlconv.out
