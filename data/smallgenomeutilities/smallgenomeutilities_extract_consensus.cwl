cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - extract_consensus
label: smallgenomeutilities_extract_consensus
doc: "Extract consensus sequence from genomic data (Note: The provided help text contains
  only container runtime error messages and no usage information).\n\nTool homepage:
  https://github.com/cbg-ethz/smallgenomeutilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
stdout: smallgenomeutilities_extract_consensus.out
