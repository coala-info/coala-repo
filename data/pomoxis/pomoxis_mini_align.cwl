cwlVersion: v1.2
class: CommandLineTool
baseCommand: pomoxis_mini_align
label: pomoxis_mini_align
doc: "The provided text does not contain help information or a description of the
  tool; it contains container execution error logs.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
stdout: pomoxis_mini_align.out
