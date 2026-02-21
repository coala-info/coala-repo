cwlVersion: v1.2
class: CommandLineTool
baseCommand: msmetaenhancer
label: msmetaenhancer
doc: "Mass Spectrometry Meta Enhancer (Note: The provided text is a container runtime
  error log and does not contain the tool's help documentation or argument definitions).\n
  \nTool homepage: https://github.com/RECETOX/MSMetaEnhancer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msmetaenhancer:0.4.1--pyhdfd78af_0
stdout: msmetaenhancer.out
