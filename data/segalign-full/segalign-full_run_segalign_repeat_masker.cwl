cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_segalign_repeat_masker
label: segalign-full_run_segalign_repeat_masker
doc: "A tool for running SegAlign with repeat masking. (Note: The provided help text
  contains container build error logs rather than command usage; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/gsneha26/SegAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/segalign-full:0.1.2.7--hdfd78af_1
stdout: segalign-full_run_segalign_repeat_masker.out
