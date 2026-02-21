cwlVersion: v1.2
class: CommandLineTool
baseCommand: savont
label: savont
doc: "A tool for Structural Variant Annotation and ONTology (Note: The provided text
  is a container build log and does not contain CLI usage instructions or argument
  definitions).\n\nTool homepage: https://github.com/bluenote-1577/savont"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savont:0.3.2--h3ab6199_0
stdout: savont.out
