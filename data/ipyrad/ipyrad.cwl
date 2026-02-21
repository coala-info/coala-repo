cwlVersion: v1.2
class: CommandLineTool
baseCommand: ipyrad
label: ipyrad
doc: "Interactive assembly and analysis of RAD-seq data (Note: The provided text is
  a system error log and does not contain CLI usage information).\n\nTool homepage:
  http://github.com/dereneaton/ipyrad"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ipyrad:0.9.107--pyhdfd78af_0
stdout: ipyrad.out
