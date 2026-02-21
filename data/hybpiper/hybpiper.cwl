cwlVersion: v1.2
class: CommandLineTool
baseCommand: hybpiper
label: hybpiper
doc: "HybPiper is a pipeline for recovery of target sequences from high-throughput
  sequencing data. (Note: The provided text is an error log and does not contain help
  information or argument definitions).\n\nTool homepage: https://github.com/mossmatters/HybPiper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
stdout: hybpiper.out
