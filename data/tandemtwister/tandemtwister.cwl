cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandemtwister
label: tandemtwister
doc: "TandemTwister is a tool for analyzing tandem repeats. (Note: The provided text
  is a container build error log and does not contain CLI help information or argument
  definitions.)\n\nTool homepage: https://github.com/Lionward/tandemtwister"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tandemtwister:0.2.0--h9948957_0
stdout: tandemtwister.out
