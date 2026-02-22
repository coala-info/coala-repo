cwlVersion: v1.2
class: CommandLineTool
baseCommand: bactopia-qc
label: bactopia-qc_bactopia
doc: "A tool for quality control within the Bactopia pipeline. (Note: The provided
  text consists of system error messages regarding container execution and disk space,
  and does not contain usage instructions or argument definitions.)\n\nTool homepage:
  https://bactopia.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia-qc:1.0.3--hdfd78af_0
stdout: bactopia-qc_bactopia.out
