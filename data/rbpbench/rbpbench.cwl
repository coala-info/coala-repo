cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbpbench
label: rbpbench
doc: "A tool for benchmarking RNA-binding protein (RBP) binding site predictions.
  (Note: The provided text contains container build logs rather than CLI help text;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/michauhl/RBPBench"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
stdout: rbpbench.out
