cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - oncogemini
  - vt
label: oncogemini_vt
doc: "The provided text does not contain help information for the tool; it contains
  system log messages and a fatal error regarding container image creation (no space
  left on device).\n\nTool homepage: https://github.com/fakedrtom/oncogemini"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
stdout: oncogemini_vt.out
