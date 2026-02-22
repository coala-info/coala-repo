cwlVersion: v1.2
class: CommandLineTool
baseCommand: ananse
label: ananse
doc: "ANalyse Networks of Active enhancers (Note: The provided text was a container
  build log and did not contain help documentation. No arguments could be extracted.)\n\
  \nTool homepage: https://github.com/vanheeringen-lab/ANANSE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ananse:0.5.1--pyhdfd78af_0
stdout: ananse.out
