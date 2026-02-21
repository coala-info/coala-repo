cwlVersion: v1.2
class: CommandLineTool
baseCommand: segalign
label: segalign-galaxy_run_segalign
doc: "The provided text is a system error log indicating a failure to build or extract
  a container image (no space left on device) and does not contain help text or argument
  definitions for the tool.\n\nTool homepage: https://github.com/gsneha26/SegAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segalign-galaxy:0.1.2.7--hdfd78af_2
stdout: segalign-galaxy_run_segalign.out
