cwlVersion: v1.2
class: CommandLineTool
baseCommand: unikseq-Bloom
label: unikseq_unikseq-Bloom
doc: "A tool from the unikseq suite. (Note: The provided help text contains only system
  logs and error messages, and does not list specific command-line arguments or usage
  instructions.)\n\nTool homepage: https://github.com/bcgsc/unikseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikseq:2.0.1--hdfd78af_0
stdout: unikseq_unikseq-Bloom.out
