cwlVersion: v1.2
class: CommandLineTool
baseCommand: srahunter
label: srahunter
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container execution/build process.\n\nTool homepage:
  https://github.com/GitEnricoNeko/srahunter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srahunter:0.0.9--pyhdfd78af_0
stdout: srahunter.out
