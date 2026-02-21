cwlVersion: v1.2
class: CommandLineTool
baseCommand: pomoxis
label: pomoxis
doc: "A suite of tools for assembly and analysis of nanopore data (Note: The provided
  text is a container execution error log and does not contain CLI help information).\n
  \nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
stdout: pomoxis.out
