cwlVersion: v1.2
class: CommandLineTool
baseCommand: tolkein
label: tolkein
doc: "A tool for processing genomic data (Note: The provided text was a container
  build log and did not contain help documentation. No arguments could be extracted
  from the input.)\n\nTool homepage: https://github.com/tolkit/tolkein"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tolkein:0.5.0--pyh7cba7a3_0
stdout: tolkein.out
