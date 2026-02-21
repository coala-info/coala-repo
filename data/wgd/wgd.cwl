cwlVersion: v1.2
class: CommandLineTool
baseCommand: wgd
label: wgd
doc: "Whole Genome Duplication (wgd) analysis tool. Note: The provided text is a container
  execution error log and does not contain command-line argument definitions.\n\n
  Tool homepage: https://github.com/heche-psb/wgd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wgd:2.0.38--pyhdfd78af_0
stdout: wgd.out
