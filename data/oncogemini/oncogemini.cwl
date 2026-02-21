cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncogemini
label: oncogemini
doc: "A tool for cancer genomics analysis. (Note: The provided input text is a system
  error log regarding a container build failure and does not contain help documentation
  or argument definitions.)\n\nTool homepage: https://github.com/fakedrtom/oncogemini"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
stdout: oncogemini.out
