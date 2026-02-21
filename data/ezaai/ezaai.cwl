cwlVersion: v1.2
class: CommandLineTool
baseCommand: ezaai
label: ezaai
doc: "The provided text contains container runtime error messages (Apptainer/Singularity)
  rather than the tool's help documentation. As a result, no specific tool description
  or arguments could be extracted.\n\nTool homepage: http://leb.snu.ac.kr/ezaai"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ezaai:1.2.4--hdfd78af_0
stdout: ezaai.out
