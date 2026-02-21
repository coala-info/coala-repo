cwlVersion: v1.2
class: CommandLineTool
baseCommand: pydnase
label: pydnase
doc: "The provided text is a container build error log and does not contain help information
  or a description for the tool. pyDNase is generally a library and suite of tools
  for analyzing DNase-seq data.\n\nTool homepage: http://jpiper.github.io/pyDNase"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydnase:0.3.0--py35_0
stdout: pydnase.out
