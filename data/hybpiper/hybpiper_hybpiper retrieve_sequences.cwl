cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hybpiper
  - retrieve_sequences
label: hybpiper_hybpiper retrieve_sequences
doc: "Retrieve sequences from HybPiper results (Note: The provided help text contained
  only system error messages regarding container execution and did not list specific
  arguments).\n\nTool homepage: https://github.com/mossmatters/HybPiper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybpiper:2.3.4--pyhdfd78af_0
stdout: hybpiper_hybpiper retrieve_sequences.out
