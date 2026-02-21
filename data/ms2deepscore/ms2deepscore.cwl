cwlVersion: v1.2
class: CommandLineTool
baseCommand: ms2deepscore
label: ms2deepscore
doc: "MS2DeepScore is a tool for deep learning-based comparison of mass spectrometry
  data. (Note: The provided text contained system error messages rather than help
  documentation; no arguments could be parsed from the input.)\n\nTool homepage: https://github.com/matchms/ms2deepscore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ms2deepscore:2.7.0--pyhdfd78af_0
stdout: ms2deepscore.out
