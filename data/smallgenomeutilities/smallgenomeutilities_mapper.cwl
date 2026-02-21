cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smallgenomeutilities
  - mapper
label: smallgenomeutilities_mapper
doc: "A utility for mapping in the smallgenomeutilities suite. (Note: The provided
  text contains container build logs and error messages rather than the tool's help
  documentation; therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/cbg-ethz/smallgenomeutilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
stdout: smallgenomeutilities_mapper.out
