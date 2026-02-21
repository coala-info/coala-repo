cwlVersion: v1.2
class: CommandLineTool
baseCommand: transindel
label: transindel
doc: "A tool for detecting transcript-supported insertions and deletions (Note: The
  provided text is a container runtime error log and does not contain help documentation
  or argument definitions).\n\nTool homepage: https://github.com/cauyrd/transIndel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transindel:2.0--hdfd78af_0
stdout: transindel.out
