cwlVersion: v1.2
class: CommandLineTool
baseCommand: spliceai
label: spliceai
doc: "SpliceAI is a deep learning-based tool to predict splicing from pre-mRNA sequence.
  (Note: The provided text appears to be a container execution error log rather than
  help text; therefore, no arguments could be extracted from the input.)\n\nTool homepage:
  https://github.com/Illumina/SpliceAI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spliceai:1.3.1--pyh864c0ab_1
stdout: spliceai.out
