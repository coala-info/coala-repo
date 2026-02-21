cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smallgenomeutilities
  - convert_reference
label: smallgenomeutilities_convert_reference
doc: "A utility to convert reference genomes, part of the smallgenomeutilities suite.\n
  \nTool homepage: https://github.com/cbg-ethz/smallgenomeutilities"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
stdout: smallgenomeutilities_convert_reference.out
