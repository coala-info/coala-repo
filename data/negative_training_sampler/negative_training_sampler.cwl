cwlVersion: v1.2
class: CommandLineTool
baseCommand: negative_training_sampler
label: negative_training_sampler
doc: "A tool for sampling negative training data. (Note: The provided text contains
  container execution logs and error messages rather than the tool's help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/kircherlab/negative_training_sampler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/negative_training_sampler:0.3.1--py_0
stdout: negative_training_sampler.out
