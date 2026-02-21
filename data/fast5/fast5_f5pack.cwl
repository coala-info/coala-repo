cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fast5
  - f5pack
label: fast5_f5pack
doc: "The provided text is a container runtime error log and does not contain help
  information or argument definitions for the tool.\n\nTool homepage: https://github.com/mateidavid/fast5"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast5:0.6.5--0
stdout: fast5_f5pack.out
