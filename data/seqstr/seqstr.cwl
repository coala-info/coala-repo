cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqstr
label: seqstr
doc: "The provided text is an error log from a container build process and does not
  contain help documentation or argument definitions for the 'seqstr' tool.\n\nTool
  homepage: https://github.com/jzhoulab/Seqstr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqstr:0.1.0--pyhdfd78af_0
stdout: seqstr.out
