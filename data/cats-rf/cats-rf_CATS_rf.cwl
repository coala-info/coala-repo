cwlVersion: v1.2
class: CommandLineTool
baseCommand: CATS_rf
label: cats-rf_CATS_rf
doc: "CATS-rf (Classifier for Alternative Transcription Start sites using Random Forest).
  Note: The provided text is a system error log regarding a container build failure
  and does not contain the tool's help documentation or argument definitions.\n\n
  Tool homepage: https://github.com/bodulic/CATS-rf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cats-rf:1.0.4--hdfd78af_0
stdout: cats-rf_CATS_rf.out
