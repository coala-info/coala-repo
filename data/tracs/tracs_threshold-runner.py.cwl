cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracs_threshold-runner.py
label: tracs_threshold-runner.py
doc: "The provided text is a system error log indicating a failure to build a container
  image due to insufficient disk space ('no space left on device'). It does not contain
  the help text for the tool. Based on the tool name hint, this script is part of
  the TRACS (Transcriptome Reconstruction and Analysis from Circular RNAs) suite,
  typically used for applying thresholds to circular RNA count data.\n\nTool homepage:
  https://github.com/gtonkinhill/tracs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
stdout: tracs_threshold-runner.py.out
