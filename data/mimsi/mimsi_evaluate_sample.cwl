cwlVersion: v1.2
class: CommandLineTool
baseCommand: mimsi_evaluate_sample
label: mimsi_evaluate_sample
doc: "Evaluate a sample using MIMSI. (Note: The provided text is a system error log
  and does not contain usage instructions or argument definitions.)\n\nTool homepage:
  https://github.com/mskcc/mimsi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimsi:0.4.5--pyhdfd78af_0
stdout: mimsi_evaluate_sample.out
