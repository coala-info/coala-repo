cwlVersion: v1.2
class: CommandLineTool
baseCommand: isoncorrect
label: isoncorrect
doc: "A tool for error correction of long reads. (Note: The provided input text contains
  system error logs regarding container execution and does not include the standard
  help documentation or argument definitions.)\n\nTool homepage: https://github.com/ksahlin/isONcorrect"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoncorrect:0.1.3.5--pyhdfd78af_0
stdout: isoncorrect.out
