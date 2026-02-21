cwlVersion: v1.2
class: CommandLineTool
baseCommand: porechop
label: porechop
doc: "A tool for finding and removing adapters from Oxford Nanopore reads. (Note:
  The provided text is a container execution error log and does not contain help documentation
  or argument definitions.)\n\nTool homepage: https://github.com/rrwick/Porechop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/porechop:0.2.4--py311h2a4ad6c_7
stdout: porechop.out
