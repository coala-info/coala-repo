cwlVersion: v1.2
class: CommandLineTool
baseCommand: cleanifier
label: cleanifier
doc: "The provided text is an error log from a container build/execution process and
  does not contain help documentation or usage instructions for the 'cleanifier' tool.
  Consequently, no arguments could be extracted.\n\nTool homepage: https://gitlab.com/rahmannlab/cleanifier"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cleanifier:1.2.0--pyhdfd78af_0
stdout: cleanifier.out
