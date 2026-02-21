cwlVersion: v1.2
class: CommandLineTool
baseCommand: psims
label: psims
doc: "The provided text is a log of a failed container build process and does not
  contain help text, usage instructions, or argument definitions for the 'psims' command-line
  tool.\n\nTool homepage: https://github.com/mobiusklein/psims"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psims:1.3.5--pyhdfd78af_0
stdout: psims.out
