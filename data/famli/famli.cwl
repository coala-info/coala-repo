cwlVersion: v1.2
class: CommandLineTool
baseCommand: famli
label: famli
doc: "Functional Analysis of Metagenomes by Likelihood Inference (Note: The provided
  text is an error log and does not contain help information or argument definitions).\n\
  \nTool homepage: https://github.com/FredHutch/FAMLI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/famli:v1.0_cv2
stdout: famli.out
