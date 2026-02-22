cwlVersion: v1.2
class: CommandLineTool
baseCommand: coregenebuilder
label: coregenebuilder
doc: "A tool for building core gene sets (Note: The provided text is an error log
  and does not contain specific usage instructions or argument definitions).\n\nTool
  homepage: https://github.com/C3BI-pasteur-fr/CoreGeneBuilder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/coregenebuilder:v1.0_cv2
stdout: coregenebuilder.out
