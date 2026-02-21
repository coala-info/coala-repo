cwlVersion: v1.2
class: CommandLineTool
baseCommand: pomoxis_mini_assemble
label: pomoxis_mini_assemble
doc: "The provided text does not contain help information for pomoxis_mini_assemble;
  it contains error logs from a container build process.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
stdout: pomoxis_mini_assemble.out
